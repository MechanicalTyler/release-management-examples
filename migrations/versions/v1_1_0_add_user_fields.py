from alembic import op
import sqlalchemy as sa

# Revision identifiers, used by Alembic.
revision = 'v1.1.0'
down_revision = None

def upgrade():
    # Commands to apply the upgrade:
    op.add_column('users', sa.Column('first_name', sa.String(length=80), nullable=True)) # Must be nullable to be backwards compatible
    op.add_column('users', sa.Column('last_name', sa.String(length=80), nullable=True)) # Must be nullable to be backwards compatible

    op.execute("""
        UPDATE users
        SET first_name = split_part(given_name, ' ', 1), last_name = split_part(given_name, ' ', 2)
    """)

def downgrade():
    # Commands to revert the upgrade:
    op.drop_column('users', 'first_name')
    op.drop_column('users', 'last_name')
