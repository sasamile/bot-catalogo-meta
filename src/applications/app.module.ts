import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { CatalogsModule } from './catalogs/catalogs.module';
import { FincasModule } from './fincas/fincas.module';
import { InboxModule } from './inbox/inbox.module';
import { KnowledgeModule } from './knowledge/knowledge.module';

@Module({
  imports: [AuthModule, CatalogsModule, FincasModule, InboxModule, KnowledgeModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
