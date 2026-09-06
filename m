Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496531E2834
	for <linux-cxl@vger.kernel.org>; Sun,  6 Sep 2026 04:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788668356; cv=none; b=X02WeR7JBRD1KihQY2M6cg4OBzBm0Sf9sDfCL7Pg9EdffsyxFFs5OUHQr7ZDkXdFFb4l0Ej9iHzyUNMYnuOM/W+HI/zCfQotcVldYXIMA6QLW4lUWaOYU3pWBSx3YDK/8x/fQ37T/IigkHeX+TpZUmmchLKmUwo8c6/d9UjgV2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788668356; c=relaxed/simple;
	bh=9N2mo09Vp8BW3fsbU5dohiA6yRdHhU4qnizpFrngp2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPhFC4LtSrkD4vbKdGiW2GyK9rosUUC4pmplM0AgJ9udnDnar5XL055twfXxzYg8i9JuWqeN/044IP8C5ooh7pO/hOODTOQg0UXn4FLjepLF2iZF803LqjDoU4G2PUXPrfzcOkT4420xG1Vl0oldjtLfP+HqhLyOvcKT7zBfhZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+0adjxl; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+0adjxl"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3964e480f76so2847587a91.1
        for <linux-cxl@vger.kernel.org>; Sat, 05 Sep 2026 21:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788668354; x=1789273154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S1IwfqSoKMqJddgM1DU8UEFPzM2uc8rz9CyVb+9qKQU=;
        b=G+0adjxlx9TWvdd6a3WYMnhw62D8cwICXuFmOtCsZ18BN7ZShllm05DpzscyzTok3h
         EFXqKYeSISFmfIjkCpL1YBuzWJPe6lWL/kuJu5a7BIMqJp6XSZv0/0UDpIIpS3fSqbnD
         t24AqTep9WWYIvmyMNMzAzh3ZJqgWO/26H7j81P63V5szMAGZS7/2shT23rcFO0s9Qkx
         DwrdDuaEnoQGOtWIs0VHnbzfb4dXRigGbnmte9+PY1c3qfsNuLWh0RAKtb3k5LNYJfNw
         fmx2rZtHhZnLKZ1gVBEyiOQDwR8+ySDin59tG9iV08qwuWB4oljr3vdI8F0H7oOXGJrf
         wcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788668354; x=1789273154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S1IwfqSoKMqJddgM1DU8UEFPzM2uc8rz9CyVb+9qKQU=;
        b=CK56fup9AWcRJiPX+Rg1qKH0sq5rsvGYmGeGoGKOHXGd52tS/2wM4SjX8Vk3CfeoTb
         dv1OFhdKk/rB245h5JUtCG+vTnfvPqb4RfZvQ31NsPDDqI7EQ2mAyvsLNNRbjPas4Z9W
         GYBIF9Q+HG5Jvqd3MK+EgfUA8Tw230lYJK2PKtUrO/chbey6ORL4jcRupnHjuZQ23uWL
         Go+1Ar4wu2SpPxkit7jTIeuDCazXizemeG7fSXL/vqyjnpCH07o+MCzAoMRz3XX9O44i
         fNvlRkENx+rx3dm0lySbt/YcY2CycRllA1VC9+6z/nFcjzIVBxyOfgs2E+wfKpE3MA8l
         k2IQ==
X-Gm-Message-State: AFuF++lexMx9FmjbE/f/BOkoWjShp/RvfwGu5oa9sp68MJLLO6E1XY+U
	QC9gKFSHT9kz/MZpzTKQqr+YWbGPCTW8hUgfKlwW/O+jXvCQ1sbhlsxNnIRjYgEBnQU=
X-Gm-Gg: AYBFou1JXWNKEh+uEzFx2yWTCJ2ZKwlImVGkyy0wtIIxWAE8m3hcKKftqkpAL15V5rQ
	aqV2k36NZMwd7jBTnKfBQN5F1UUl2Dz99kfyJfHdBzYkAUsdvGvO4x8RNQRBH5tSyd6ChNKU0ac
	9JUdwPvPd1zNmhomSYCU5l3bd6VyYLOtnzlhWLBr5AoCg1JarEWB0tNbjc5GiILOUeUCCjCkmIX
	iqYn3C8ezyOVafUs4gRUVG35my2msQODhS0qMvHqHCF2tVrgod3zfQ526DAu/smo+o1WrsxgPjw
	yZ3p5yLJicwHdezW+LiS4BEFPPSjTU4eZW4uAMNV1g/9bB4BWKXfIjERCY/7N6DVETZDQVAyBFc
	024Uw72c5dfo4VVUnCV4jOtWuyLavI8NnlOC9Iy6OaUKIo4xjvSuPo/kJvhv0P2gnXvoW0GXz02
	o7PJ7AG3FmC7v37XT2d711gUnA5Kjup+LFfgrm4YV5m1hMI5jQNXLfSk/DDjZfvvZ+Q5xdyJck5
	xIvdu3KRJ3zULrv02xyiU4Xppga
X-Received: by 2002:a17:90b:55c6:b0:398:9be5:b41d with SMTP id 98e67ed59e1d1-39b26299670mr24438009a91.24.1788668353591;
        Sat, 05 Sep 2026 21:19:13 -0700 (PDT)
Received: from acer-nitro-anv15-41.entro.com ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260f64ecsm13202675a91.8.2026.09.05.21.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 21:19:12 -0700 (PDT)
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: dave.jiang@intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	benjamin.cheatham@amd.com,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Subject: [ndctl PATCH] cxl/test: Add ELC MCE alias retirement tests
Date: Sun,  6 Sep 2026 09:48:44 +0530
Message-ID: <20260906041844.13891-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ELC alias retirement depends on the error severity and on whether
vendor-specific MCE rules consider the reported address usable. Add
regression coverage for these decisions to cxl-elc.sh.

Inject MCE records through the mce-inject debugfs interface and verify
the resulting bank status and alias-offlining messages in dmesg. Test
corrected and uncorrected errors on Intel, and exercise the poison,
deferred, and legacy bank-4 cases required by AMD address validation.

Derive the ELC SPA and its alias from cxl-list output, select offline
test addresses from lsmem, and discover available MCA banks dynamically.
Use a distinct SPA for each case and clean up modules loaded by the test.

Suggested-by: Ben Cheatham <benjamin.cheatham@amd.com>
Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
---
Testing:
The test was run under virtme-ng with cxl_test configured for Extended
Linear Cache operation:

Intel, GenuineIntel:
--------------------

1. vng -v -r ./arch/x86/boot/bzImage --disable-kvm --qemu-opts='-cpu Skylake-Server-v4,+mce,+mca -m 4G -machine q35,cxl=on -object memory-backend-ram,id=cxl-mem0,size=512M -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0 -device cxl-rp,port=0,bus=cxl.0,id=root_port0,chassis=0,slot=0 -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem-device0 -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=512M'

2 . Go to ndctl-main directoy with this patches 

env NDCTL="$PWD/build/ndctl/ndctl" 
DAXCTL="$PWD/build/daxctl/daxctl" 
CXL="$PWD/build/cxl/cxl" 
./test/cxl-elc.sh

RESULT:
--------

PASS Intel corrected: alias no
PASS Intel uncorrected: alias yes
CXL ELC MCE validation passed for GenuineIntel: 2 cases
-----------------------------------------------------------------

AMD, AuthenticAMD legacy MCA: 
-----------------------------

1. vng -v -r ./arch/x86/boot/bzImage --disable-kvm --qemu-opts='-cpu EPYC-Milan -m 4G -machine q35,cxl=on -object memory-backend-ram,id=cxl-mem0,size=512M -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0 -device cxl-rp,port=0,bus=cxl.0,id=root_port0,chassis=0,slot=0 -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem-device0 -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=512M'

2. Go to ndctl-main directoy with this patches  
env NDCTL="$PWD/build/ndctl/ndctl" 
DAXCTL="$PWD/build/daxctl/daxctl" 
CXL="$PWD/build/cxl/cxl" 
./test/cxl-elc.sh

RESULT:
---------
PASS AMD plain corrected: alias no
PASS AMD plain uncorrected: alias no
PASS AMD poison-only (invalid encoding): alias no
PASS AMD deferred without poison: alias no
PASS AMD deferred with poison: alias yes
PASS AMD uncorrected with poison: alias yes
PASS AMD bank-4 non-memory poison (invalid encoding): alias no
PASS AMD legacy bank-4 corrected DRAM ECC: alias no
CXL ELC MCE validation passed for AuthenticAMD: 8 cases

 test/cxl-elc.sh | 313 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 312 insertions(+), 1 deletion(-)

diff --git a/test/cxl-elc.sh b/test/cxl-elc.sh
index cfa09cb..bd600b4 100755
--- a/test/cxl-elc.sh
+++ b/test/cxl-elc.sh
@@ -8,6 +8,30 @@ rc=77
 
 set -ex
 
+mce_inject_loaded=0
+
+cleanup()
+{
+	local status=$?
+	local cleanup_status=0
+
+	trap - EXIT ERR
+	set +e
+
+	if ((mce_inject_loaded)); then
+		modprobe -r mce-inject || cleanup_status=1
+	fi
+
+	modprobe -r cxl_test || cleanup_status=1
+
+	if ((status == 0 && cleanup_status != 0)); then
+		status=1
+	fi
+
+	exit "$status"
+}
+
+trap cleanup EXIT
 trap 'err $LINENO' ERR
 
 check_prereq "jq"
@@ -85,10 +109,297 @@ compare_bases()
 	((cxlrd_hpa == ep1_hpa - ep1_size)) || err "$LINENO"
 }
 
+mce_skip()
+{
+	echo "SKIP CXL ELC MCE subtest: $*"
+	return 0
+}
+
+dmesg_count()
+{
+	dmesg | grep -F -c -- "$1" || true
+}
+
+wait_for_dmesg()
+{
+	local pattern="$1"
+	local previous="$2"
+	local count
+
+	for _ in {1..50}; do
+		count="$(dmesg_count "$pattern")"
+		((count > previous)) && return 0
+		sleep 0.1
+	done
+
+	return 1
+}
+
+address_is_offline()
+{
+	local address="$1"
+	local range start end
+
+	while read -r range; do
+		[[ "$range" == *-* ]] || continue
+		start=$(( ${range%%-*} ))
+		end=$(( ${range##*-} ))
+		((address >= start && address <= end)) && return 0
+	done < <(echo "$lsmem_json" | jq -r \
+		'.memory[] | select((.state | ascii_downcase) == "offline") |
+		 .range')
+
+	return 1
+}
+
+find_offline_spas()
+{
+	local nr_spas="$1"
+	local range start end low high candidate alias spa_string alias_string
+	local page_size region_end cache_end i
+	local stride=0x10000
+
+	lsmem_json="$(lsmem --json --bytes --output RANGE,STATE)"
+	page_size="$(getconf PAGESIZE)"
+	region_end=$((region_hpa + region_size))
+	cache_end=$((region_hpa + elc_size))
+	inject_spas=()
+	alias_spas=()
+
+	while read -r range; do
+		[[ "$range" == *-* ]] || continue
+		start=$(( ${range%%-*} ))
+		end=$(( ${range##*-} ))
+
+		low=$start
+		((low < region_hpa)) && low=$region_hpa
+		high=$((end + 1))
+		((high > cache_end)) && high=$cache_end
+		((low < high)) || continue
+
+		# Stay away from the first pages of the hotplugged range.
+		candidate=$((low + stride))
+		candidate=$((
+			(candidate + page_size - 1) / page_size * page_size
+		))
+		inject_spas=()
+		alias_spas=()
+		for ((i = 0; i < nr_spas; i++)); do
+			candidate=$((candidate + (i > 0 ? stride : 0)))
+			alias=$((candidate + elc_size))
+			((candidate < high && alias < region_end)) || break
+			address_is_offline "$alias" || break
+			printf -v spa_string '0x%x' "$candidate"
+			printf -v alias_string '0x%x' "$alias"
+			inject_spas+=("$spa_string")
+			alias_spas+=("$alias_string")
+		done
+		((${#inject_spas[@]} == nr_spas)) || continue
+		return 0
+	done < <(echo "$lsmem_json" | jq -r \
+		'.memory[] | select((.state | ascii_downcase) == "offline") |
+		 .range')
+
+	return 1
+}
+
+discover_mca_banks()
+{
+	local path name
+
+	for path in \
+		/sys/devices/system/machinecheck/machinecheck0/bank[0-9]*; do
+		[[ -e "$path" ]] || continue
+		name="${path##*/}"
+		printf '%s\n' "${name#bank}"
+	done | sort -n -u
+}
+
+has_bank()
+{
+	local wanted="$1"
+	local bank
+
+	for bank in "${mca_banks[@]}"; do
+		[[ "$bank" == "$wanted" ]] && return 0
+	done
+
+	return 1
+}
+
+select_mce_parameters()
+{
+	local bank
+
+	vendor="$(awk '/^vendor_id/{ print $3; exit }' /proc/cpuinfo)"
+	readarray -t mca_banks < <(discover_mca_banks)
+	((${#mca_banks[@]})) || return 1
+
+	case "$vendor" in
+	GenuineIntel)
+		test_bank="${mca_banks[-1]}"
+		test_case_count=2
+		;;
+	AuthenticAMD)
+		# The usable-address corrected-error case is the legacy bank-4 DRAM
+		# ECC encoding (XEC 8). It is not valid for an SMCA bank.
+		grep -qw smca /proc/cpuinfo && return 1
+		has_bank 4 || return 1
+		non_b4_bank=
+		for bank in "${mca_banks[@]}"; do
+			[[ "$bank" == 4 ]] || non_b4_bank="$bank"
+		done
+		[[ -n "$non_b4_bank" ]] || return 1
+		test_case_count=8
+		;;
+	*)
+		return 1
+		;;
+	esac
+}
+
+inject_mce()
+{
+	local status="$1"
+	local bank="$2"
+	local mce_inject=/sys/kernel/debug/mce-inject
+
+	echo sw > "$mce_inject/flags"
+	echo "$status" > "$mce_inject/status"
+	echo 0x80 > "$mce_inject/misc"
+	echo "$inject_spa" > "$mce_inject/addr"
+	echo "$bank" > "$mce_inject/bank"
+}
+
+run_mce_case()
+{
+	local name="$1"
+	local status="$2"
+	local bank="$3"
+	local expect_alias="$4"
+	local index="$5"
+	local alias_msg bank_msg status_tag
+	local alias_before bank_before
+
+	inject_spa="${inject_spas[$index]}"
+	alias_spa="${alias_spas[$index]}"
+	alias_msg="Offlining aliased SPA address0: $alias_spa"
+	status_tag="${status#0x}"
+	bank_msg="Bank $bank: $status_tag"
+	alias_before="$(dmesg_count "$alias_msg")"
+	bank_before="$(dmesg_count "$bank_msg")"
+
+	inject_mce "$status" "$bank"
+	wait_for_dmesg "$bank_msg" "$bank_before" || err "$LINENO"
+
+	if [[ "$expect_alias" == "yes" ]]; then
+		wait_for_dmesg "$alias_msg" "$alias_before" || err "$LINENO"
+	else
+		(($(dmesg_count "$alias_msg") == alias_before)) || \
+			err "$LINENO"
+	fi
+
+	echo "PASS $name: SPA $inject_spa, alias $alias_spa, bank $bank, alias $expect_alias"
+}
+
+run_intel_mce_cases()
+{
+	run_mce_case "Intel corrected" 0x9c00000000000080 \
+		"$test_bank" no 0
+	run_mce_case "Intel uncorrected" 0xbc00000000000080 \
+		"$test_bank" yes 1
+}
+
+run_amd_mce_cases()
+{
+	# Mirror the full AMD matrix documented with the kernel fix. The two
+	# poison-only records have UC=0 and Deferred=0, so they are not valid
+	# architectural records. Keep them as software-injection robustness
+	# coverage and expect the corrected-error filter to reject them.
+	run_mce_case "AMD plain corrected" 0x9c00000000000080 \
+		"$non_b4_bank" no 0
+	run_mce_case "AMD plain uncorrected" 0xbc00000000000080 \
+		"$non_b4_bank" no 1
+	run_mce_case "AMD poison-only (invalid encoding)" \
+		0x9c00080000000080 "$non_b4_bank" no 2
+	run_mce_case "AMD deferred without poison" 0x9c00100000000080 \
+		"$non_b4_bank" no 3
+	run_mce_case "AMD deferred with poison" 0x9c00180000000080 \
+		"$non_b4_bank" yes 4
+	run_mce_case "AMD uncorrected with poison" 0xbc00080000000080 \
+		"$non_b4_bank" yes 5
+	run_mce_case "AMD bank-4 non-memory poison (invalid encoding)" \
+		0x9c00080000000080 4 no 6
+	run_mce_case "AMD legacy bank-4 corrected DRAM ECC" \
+		0x9c00000000080000 4 no 7
+}
+
+test_mce_alias()
+{
+	local region_json
+
+	[[ "$(uname -m)" == "x86_64" ]] || {
+		mce_skip "x86_64 is required"
+		return 0
+	}
+	command -v lsmem >/dev/null 2>&1 || {
+		mce_skip "lsmem is unavailable"
+		return 0
+	}
+
+	region_json="$(echo "$json" | jq -c --arg region "$region" \
+		'.[] | select(.region == $region)')"
+	region_hpa="$(echo "$region_json" | jq -r '.resource // empty')"
+	region_size="$(echo "$region_json" | jq -r '.size // empty')"
+	elc_size="$(echo "$region_json" | jq -r \
+		'.extended_linear_cache_size // empty')"
+
+	[[ "$region_hpa" =~ ^[0-9]+$ ]] || err "$LINENO"
+	[[ "$region_size" =~ ^[0-9]+$ ]] || err "$LINENO"
+	[[ "$elc_size" =~ ^[0-9]+$ ]] || err "$LINENO"
+	((elc_size > 0x10000 && region_size >= elc_size * 2)) || \
+		err "$LINENO"
+
+	select_mce_parameters || {
+		mce_skip "no supported MCA bank configuration for $vendor"
+		return 0
+	}
+
+	if [[ ! -d /sys/module/mce_inject ]]; then
+		modprobe mce-inject || {
+			mce_skip "mce-inject module is unavailable"
+			return 0
+		}
+		mce_inject_loaded=1
+	fi
+	[[ -d /sys/kernel/debug/mce-inject ]] || {
+		mce_skip "mce-inject debugfs interface is unavailable"
+		return 0
+	}
+
+	find_offline_spas "$test_case_count" || {
+		mce_skip "offline lsmem range lacks enough ELC test addresses"
+		return 0
+	}
+
+	case "$vendor" in
+	GenuineIntel)
+		run_intel_mce_cases
+		;;
+	AuthenticAMD)
+		run_amd_mce_cases
+		;;
+	esac
+
+	echo "CXL ELC MCE validation passed for $vendor: $test_case_count cases"
+}
+
 find_region
 retrieve_info
 compare_sizes
 compare_bases
 
+# Check before injecting the expected machine-check messages.
+check_dmesg "$LINENO"
+test_mce_alias
 check_dmesg "$LINENO"
-modprobe -r cxl_test

base-commit: 15e932c4e1318a9608ad9b799ad83a32a8b5970d
-- 
2.43.0

