from alembic import op
import sqlalchemy as sa

# Revision identifiers, used by Alembic.
revision = 'v1.4.0'
down_revision = 'v1.2.0'

def upgrade():
    op.drop_column('users', 'given_name')

def downgrade():
    op.add_column('users', sa.Column('given_name', sa.String(length=80), nullable=True))
    op.execute("""
        UPDATE users
        SET given_name = concat(first_name, ' ', last_name)
    """)
