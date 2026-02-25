/**
 * Roles de usuario. Por defecto nuevos usuarios tienen "user".
 * Solo "admin" puede crear, actualizar y borrar fincas.
 */
export enum UserRole {
  USER = 'user',
  ADMIN = 'admin',
}
