from alembic import op
import sqlalchemy as sa

# Revision identifiers, used by Alembic.
revision = 'v1.2.0'
down_revision = 'v1.1.0'

def upgrade():
    op.execute("""
        UPDATE users
        SET first_name = split_part(given_name, ' ', 1), last_name = split_part(given_name, ' ', 2)
    """)

    op.alter_column('users', 'first_name', nullable=False)
    op.alter_column('users', 'last_name', nullable=False)

    # set given_name to nullable so we can stop populating it
    op.alter_column('users', 'given_name', nullable=True)

def downgrade():
    # Commands to revert the upgrade:
    op.alter_column('users', 'first_name', nullable=True)
    op.alter_column('users', 'last_name', nullable=True)

    op.alter_column('users', 'given_name', nullable=False)
