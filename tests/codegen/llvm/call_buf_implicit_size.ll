; ModuleID = 'bpftrace'
source_filename = "bpftrace"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf-pc-linux"

%buffer_16_t = type { i8, [16 x i8] }

; Function Attrs: nounwind
declare i64 @llvm.bpf.pseudo(i64, i64) #0

define i64 @"kprobe:f"(i8* nocapture readnone) local_unnamed_addr section "s_kprobe:f_1" {
entry:
  %"@x_key" = alloca i64, align 8
  %buffer = alloca %buffer_16_t, align 8
  %1 = getelementptr inbounds %buffer_16_t, %buffer_16_t* %buffer, i64 0, i32 0
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* nonnull %1)
  store i8 16, i8* %1, align 8
  %2 = getelementptr inbounds %buffer_16_t, %buffer_16_t* %buffer, i64 0, i32 1
  %3 = getelementptr inbounds [16 x i8], [16 x i8]* %2, i64 0, i64 0
  call void @llvm.memset.p0i8.i64(i8* nonnull align 1 %3, i8 0, i64 16, i1 false)
  %probe_read = call i64 inttoptr (i64 4 to i64 ([16 x i8]*, i32, i64)*)([16 x i8]* nonnull %2, i8 16, i64 0)
  %4 = bitcast i64* %"@x_key" to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* nonnull %4)
  store i64 0, i64* %"@x_key", align 8
  %pseudo = call i64 @llvm.bpf.pseudo(i64 1, i64 1)
  %update_elem = call i64 inttoptr (i64 2 to i64 (i64, i64*, %buffer_16_t*, i64)*)(i64 %pseudo, i64* nonnull %"@x_key", %buffer_16_t* nonnull %buffer, i64 0)
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* nonnull %4)
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* nonnull %1)
  ret i64 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #1

attributes #0 = { nounwind }
attributes #1 = { argmemonly nounwind }
