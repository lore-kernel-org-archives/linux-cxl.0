Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4A68287E
	for <linux-cxl@vger.kernel.org>; Tue,  6 Oct 2026 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791256159; cv=none; b=DaJUemS5+JXYtmt/hafCOHw0nbgVvfXljw75xrFokV4MQ08IefQzoLmy2e6fXLJzENRitL2BSH3pp34+KeTwcfbj5EzDD/U5sb/zUy/Wo+MAs8bAg72tIOd5KLUr3kx1shX9B5PefpiiJpAm7EHjaxnJU/I86LqKKf+it36Rh9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791256159; c=relaxed/simple;
	bh=OVft/xbEqPgCYgTAUo60M/Gr4LyQYSlQ1eFSvv483Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bH3O/9Ao1t7F/RCXczTYlTrVXjLXN+uFajQTeIdS7F4l6mhcEkKbCnZj7VPzaQ/y/qLbL0FibzDjrdsura181lYWrgXzEqSz24PqJCwmI3uxj2/Qv6DWBMpANsaVhuZyVrFEZnp/8KKSk84e5fd7Kpgrsw11orbXc89dmZ/RNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHcYh23O; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHcYh23O"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-351348eb579so693672eec.0
        for <linux-cxl@vger.kernel.org>; Mon, 05 Oct 2026 20:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791256156; x=1791860956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XcBjTo8k6f4ZxjFF0dkhyrWCRKv8XDO/3DYCWWX3kBk=;
        b=AHcYh23ObOlgqRqqoa9dtVgq91wyVEZZpNEclhjNnSQMnjzdjSBPF+XAIsa0jft/PE
         9ylhMznp5SVX/Ru8HITen7JkYco2MIbxaiCdP94JMt1P9taqDh/tOBTK/hDlHevYD3Py
         yAiX/A8zDtKx54cs2XXOHrX0UmLb/dEzzhaTl+6njVgfgcM2vrm4KJYrAx9kNJIgfnsj
         HXah6yat4fowPfJnBm705xwP2/zrPKsWlEo70sl4O1rjZgNRNlym6Is6upuipmTwhbQN
         ku05jZ69lzNXx2gMj+fn36/D9CFxOIEC7/Md4a56LpUmGZO57IT3QiyXS0HoSul8j86N
         9ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791256156; x=1791860956;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XcBjTo8k6f4ZxjFF0dkhyrWCRKv8XDO/3DYCWWX3kBk=;
        b=w6sj9AbQk57LRPvb8kTuv+DRqPjB0haZmQGq0fZRE7KVvMHYEy0VKJh9aw+gr60fil
         1pUxkk1hrC8t8Omt3pyWS17/Pq4OYQDSfzZkr3xO4SRdZUi2QZxiDjCVlZeRfu8/0OO7
         Ba099AmDcAmNChRwI7c5AQMvPjbM8MpLR1KrkIQ57pjONnykwshPcVks9zQoFANF5Lxb
         W4F1edlvXwGG0O0TtJGryh6orug1GvKDA7d3002n+dc2KrDMej8sfnalr6krd9frz+Si
         aWJo9hEgfr1/hu85p6bX4nOyqySxLlAHLyHCwgkAPt/Nnp5JqlqQGjh1kQIgDt3UW6MI
         /Tig==
X-Gm-Message-State: AFq9FYImnM2GuMldVHpROnpxatkptS1ux6vgkK/EhC7/Fu4KyAAEwNtM
	6Jf2JKYXbSfXzGn2U/Rm5RmiPtctFi46CuV6gTAHENXq4kXemFIhM05M
X-Gm-Gg: AYBFou2GRrR+hqXHI2+dYQpVezKB+x2Aq8+yJBAyggeEermSo2z4hyIQYMDzCQFAFdT
	tEfLL81yh1b+14h+//XBT4K+XZncOO1cK54K01FTKN8sRx4dgiZF+6hQZI9qKsQGp4bt5aQ2vEr
	wPz0w3lC4wEYFHQgmoXt0DNIC/CZ+ZuiBEQJL4QW3bjJS54yNT8SbXE/5g5cDZDtrNGOGVW/XRy
	03AxtFOuV6hl7aU8Hcb9M8XIimh3aXSqtJKp6PKxGagVmU98ae9NP2iigMf14PeWU1jioYdhn7K
	5uSpVPJV0IvNhmoto48sPo4B08oae+i1D8ctxX4pfbE+sdtLBPhk9tlKB10meDEq22Pr4hEqRQz
	s3+g8orljXk4no8lJiQe8pVMhbhjKTsAAhCTHUBzfWIoUQvSWw0W/jeWmTNhTYxGCHDhLNWEEgr
	Go8hcwQXi2GQu1pqQKh5uaTVTddGOcazfS1JI6HQRY0+SZrZzyxP8LwCB95NSpMxvgUO+nIO3Bw
	A==
X-Received: by 2002:a05:7301:2b5:b0:34e:f619:eeba with SMTP id 5a478bee46e88-3514501ead2mr1709782eec.3.1791256155809;
        Mon, 05 Oct 2026 20:09:15 -0700 (PDT)
Received: from localhost ([115.97.153.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469f7617sm3018821eec.9.2026.10.05.20.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 20:09:15 -0700 (PDT)
Date: Tue, 6 Oct 2026 08:39:12 +0530
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev, dave.jiang@intel.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [ndctl PATCH] cxl/test: Add ELC MCE alias retirement tests
Message-ID: <asRmWIC64soVVL4Q@acer-nitro-anv15-41>
References: <20260906041844.13891-1-shaikhkamal2012@gmail.com>
 <aqqtlTAh9faQzqCE@acer-nitro-anv15-41>
 <c60ee4b7-f2b5-4c45-8414-6f7c31462d28@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c60ee4b7-f2b5-4c45-8414-6f7c31462d28@amd.com>

On Wed, Sep 16, 2026 at 11:40:53AM -0500, Cheatham, Benjamin wrote:
> Hi Shaikh,
> 
> Sorry I've been on vacation for the last week and half and just now starting to get caught up. I don't have time
> to do more than just a quick glance at the moment, but I'll come back and do a full review in the next few days.
> 
> On 9/16/2026 9:54 AM, Shaikh Kamaluddin wrote:
> > Hi Alison and Ben,
> > 
> > Gentle ping on this patch. Could you please take a look when you have a
> > time?
> > 
> > Thanks,
> > Shaikh Kamaluddin
> > 
> > On Sun, Sep 06, 2026 at 09:48:44AM +0530, Shaikh Kamaluddin wrote:
> >> ELC alias retirement depends on the error severity and on whether
> 
> You should spell out ELC on the first usage, helps with context.

Hello Ben,
Sorry for delay reply.
I will spell out Extended Linear Cache(ELC) on its first use.

> >> vendor-specific MCE rules consider the reported address usable. Add
> >> regression coverage for these decisions to cxl-elc.sh.
> >>
> >> Inject MCE records through the mce-inject debugfs interface and verify
> >> the resulting bank status and alias-offlining messages in dmesg. Test
> >> corrected and uncorrected errors on Intel, and exercise the poison,
> >> deferred, and legacy bank-4 cases required by AMD address validation.
> >>
> >> Derive the ELC SPA and its alias from cxl-list output, select offline
> >> test addresses from lsmem, and discover available MCA banks dynamically.
> >> Use a distinct SPA for each case and clean up modules loaded by the test.
> >>
> >> Suggested-by: Ben Cheatham <benjamin.cheatham@amd.com>
> >> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> >> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> >> ---
> >> Testing:
> >> The test was run under virtme-ng with cxl_test configured for Extended
> >> Linear Cache operation:
> >>
> >> Intel, GenuineIntel:
> >> --------------------
> >>
> >> 1. vng -v -r ./arch/x86/boot/bzImage --disable-kvm --qemu-opts='-cpu Skylake-Server-v4,+mce,+mca -m 4G -machine q35,cxl=on -object memory-backend-ram,id=cxl-mem0,size=512M -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0 -device cxl-rp,port=0,bus=cxl.0,id=root_port0,chassis=0,slot=0 -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem-device0 -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=512M'
> >>
> >> 2 . Go to ndctl-main directoy with this patches 
> >>
> >> env NDCTL="$PWD/build/ndctl/ndctl" 
> >> DAXCTL="$PWD/build/daxctl/daxctl" 
> >> CXL="$PWD/build/cxl/cxl" 
> >> ./test/cxl-elc.sh
> >>
> >> RESULT:
> >> --------
> >>
> >> PASS Intel corrected: alias no
> >> PASS Intel uncorrected: alias yes
> >> CXL ELC MCE validation passed for GenuineIntel: 2 cases
> >> -----------------------------------------------------------------
> >>
> >> AMD, AuthenticAMD legacy MCA: 
> >> -----------------------------
> >>
> >> 1. vng -v -r ./arch/x86/boot/bzImage --disable-kvm --qemu-opts='-cpu EPYC-Milan -m 4G -machine q35,cxl=on -object memory-backend-ram,id=cxl-mem0,size=512M -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0 -device cxl-rp,port=0,bus=cxl.0,id=root_port0,chassis=0,slot=0 -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem-device0 -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=512M'
> 
> One thing to note: real Milan hardware doesn't support CXL; CXL 1.1 support was added in the next generation (Genoa). The kernel is also broken on Genoa since the driver is geared towards CXL 2.0+, so I'd
> recommend a Turin+ machine for hardware testing.

Thanks for clarifying. I used the EPYC-Milan QEMU CPU model under TCG
only to exercise the legacy AMD MCA path, it was not intended to imply
CXL support on physical Milan Hardware. The ELC setup was provided by
cxl_test.

Agreed that Turin would be appropriate platform for any physical AMD
hardware testing.
> 
> I don't think this is really applicable though, since I'm 99% sure AMD hardware doesn't have ELC support to begin with. I'll try running the tests on hardware and see what happens, though I think it will just
> break. There may need to be a check to see what platform the test is running on so we can skip platforms that don't have support (i.e. real AMD hardware).
> 
> I think it's probably fine to leave the test in place though in the event AMD adds ELC support later on.
> 

That make sense. The AMD cases are intended to exercise the
vendor-specific MCE address-validation paths against the mock ELC region
created by cxl_test, rather than claim ELC support on physical AMD
hardware.

I agree that the test should skip cleanly when ELC support is
unavailable, while retaining the AMD mock coverage for possible future
hardware support.

Thanks,
Shaikh Kamal

> Thanks,
> Ben
> >>
> >> 2. Go to ndctl-main directoy with this patches  
> >> env NDCTL="$PWD/build/ndctl/ndctl" 
> >> DAXCTL="$PWD/build/daxctl/daxctl" 
> >> CXL="$PWD/build/cxl/cxl" 
> >> ./test/cxl-elc.sh
> >>
> >> RESULT:
> >> ---------
> >> PASS AMD plain corrected: alias no
> >> PASS AMD plain uncorrected: alias no
> >> PASS AMD poison-only (invalid encoding): alias no
> >> PASS AMD deferred without poison: alias no
> >> PASS AMD deferred with poison: alias yes
> >> PASS AMD uncorrected with poison: alias yes
> >> PASS AMD bank-4 non-memory poison (invalid encoding): alias no
> >> PASS AMD legacy bank-4 corrected DRAM ECC: alias no
> >> CXL ELC MCE validation passed for AuthenticAMD: 8 cases
> >>
> >>  test/cxl-elc.sh | 313 +++++++++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 312 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/test/cxl-elc.sh b/test/cxl-elc.sh
> >> index cfa09cb..bd600b4 100755
> >> --- a/test/cxl-elc.sh
> >> +++ b/test/cxl-elc.sh
> >> @@ -8,6 +8,30 @@ rc=77
> >>  
> >>  set -ex
> >>  
> >> +mce_inject_loaded=0
> >> +
> >> +cleanup()
> >> +{
> >> +	local status=$?
> >> +	local cleanup_status=0
> >> +
> >> +	trap - EXIT ERR
> >> +	set +e
> >> +
> >> +	if ((mce_inject_loaded)); then
> >> +		modprobe -r mce-inject || cleanup_status=1
> >> +	fi
> >> +
> >> +	modprobe -r cxl_test || cleanup_status=1
> >> +
> >> +	if ((status == 0 && cleanup_status != 0)); then
> >> +		status=1
> >> +	fi
> >> +
> >> +	exit "$status"
> >> +}
> >> +
> >> +trap cleanup EXIT
> >>  trap 'err $LINENO' ERR
> >>  
> >>  check_prereq "jq"
> >> @@ -85,10 +109,297 @@ compare_bases()
> >>  	((cxlrd_hpa == ep1_hpa - ep1_size)) || err "$LINENO"
> >>  }
> >>  
> >> +mce_skip()
> >> +{
> >> +	echo "SKIP CXL ELC MCE subtest: $*"
> >> +	return 0
> >> +}
> >> +
> >> +dmesg_count()
> >> +{
> >> +	dmesg | grep -F -c -- "$1" || true
> >> +}
> >> +
> >> +wait_for_dmesg()
> >> +{
> >> +	local pattern="$1"
> >> +	local previous="$2"
> >> +	local count
> >> +
> >> +	for _ in {1..50}; do
> >> +		count="$(dmesg_count "$pattern")"
> >> +		((count > previous)) && return 0
> >> +		sleep 0.1
> >> +	done
> >> +
> >> +	return 1
> >> +}
> >> +
> >> +address_is_offline()
> >> +{
> >> +	local address="$1"
> >> +	local range start end
> >> +
> >> +	while read -r range; do
> >> +		[[ "$range" == *-* ]] || continue
> >> +		start=$(( ${range%%-*} ))
> >> +		end=$(( ${range##*-} ))
> >> +		((address >= start && address <= end)) && return 0
> >> +	done < <(echo "$lsmem_json" | jq -r \
> >> +		'.memory[] | select((.state | ascii_downcase) == "offline") |
> >> +		 .range')
> >> +
> >> +	return 1
> >> +}
> >> +
> >> +find_offline_spas()
> >> +{
> >> +	local nr_spas="$1"
> >> +	local range start end low high candidate alias spa_string alias_string
> >> +	local page_size region_end cache_end i
> >> +	local stride=0x10000
> >> +
> >> +	lsmem_json="$(lsmem --json --bytes --output RANGE,STATE)"
> >> +	page_size="$(getconf PAGESIZE)"
> >> +	region_end=$((region_hpa + region_size))
> >> +	cache_end=$((region_hpa + elc_size))
> >> +	inject_spas=()
> >> +	alias_spas=()
> >> +
> >> +	while read -r range; do
> >> +		[[ "$range" == *-* ]] || continue
> >> +		start=$(( ${range%%-*} ))
> >> +		end=$(( ${range##*-} ))
> >> +
> >> +		low=$start
> >> +		((low < region_hpa)) && low=$region_hpa
> >> +		high=$((end + 1))
> >> +		((high > cache_end)) && high=$cache_end
> >> +		((low < high)) || continue
> >> +
> >> +		# Stay away from the first pages of the hotplugged range.
> >> +		candidate=$((low + stride))
> >> +		candidate=$((
> >> +			(candidate + page_size - 1) / page_size * page_size
> >> +		))
> >> +		inject_spas=()
> >> +		alias_spas=()
> >> +		for ((i = 0; i < nr_spas; i++)); do
> >> +			candidate=$((candidate + (i > 0 ? stride : 0)))
> >> +			alias=$((candidate + elc_size))
> >> +			((candidate < high && alias < region_end)) || break
> >> +			address_is_offline "$alias" || break
> >> +			printf -v spa_string '0x%x' "$candidate"
> >> +			printf -v alias_string '0x%x' "$alias"
> >> +			inject_spas+=("$spa_string")
> >> +			alias_spas+=("$alias_string")
> >> +		done
> >> +		((${#inject_spas[@]} == nr_spas)) || continue
> >> +		return 0
> >> +	done < <(echo "$lsmem_json" | jq -r \
> >> +		'.memory[] | select((.state | ascii_downcase) == "offline") |
> >> +		 .range')
> >> +
> >> +	return 1
> >> +}
> >> +
> >> +discover_mca_banks()
> >> +{
> >> +	local path name
> >> +
> >> +	for path in \
> >> +		/sys/devices/system/machinecheck/machinecheck0/bank[0-9]*; do
> >> +		[[ -e "$path" ]] || continue
> >> +		name="${path##*/}"
> >> +		printf '%s\n' "${name#bank}"
> >> +	done | sort -n -u
> >> +}
> >> +
> >> +has_bank()
> >> +{
> >> +	local wanted="$1"
> >> +	local bank
> >> +
> >> +	for bank in "${mca_banks[@]}"; do
> >> +		[[ "$bank" == "$wanted" ]] && return 0
> >> +	done
> >> +
> >> +	return 1
> >> +}
> >> +
> >> +select_mce_parameters()
> >> +{
> >> +	local bank
> >> +
> >> +	vendor="$(awk '/^vendor_id/{ print $3; exit }' /proc/cpuinfo)"
> >> +	readarray -t mca_banks < <(discover_mca_banks)
> >> +	((${#mca_banks[@]})) || return 1
> >> +
> >> +	case "$vendor" in
> >> +	GenuineIntel)
> >> +		test_bank="${mca_banks[-1]}"
> >> +		test_case_count=2
> >> +		;;
> >> +	AuthenticAMD)
> >> +		# The usable-address corrected-error case is the legacy bank-4 DRAM
> >> +		# ECC encoding (XEC 8). It is not valid for an SMCA bank.
> >> +		grep -qw smca /proc/cpuinfo && return 1
> >> +		has_bank 4 || return 1
> >> +		non_b4_bank=
> >> +		for bank in "${mca_banks[@]}"; do
> >> +			[[ "$bank" == 4 ]] || non_b4_bank="$bank"
> >> +		done
> >> +		[[ -n "$non_b4_bank" ]] || return 1
> >> +		test_case_count=8
> >> +		;;
> >> +	*)
> >> +		return 1
> >> +		;;
> >> +	esac
> >> +}
> >> +
> >> +inject_mce()
> >> +{
> >> +	local status="$1"
> >> +	local bank="$2"
> >> +	local mce_inject=/sys/kernel/debug/mce-inject
> >> +
> >> +	echo sw > "$mce_inject/flags"
> >> +	echo "$status" > "$mce_inject/status"
> >> +	echo 0x80 > "$mce_inject/misc"
> >> +	echo "$inject_spa" > "$mce_inject/addr"
> >> +	echo "$bank" > "$mce_inject/bank"
> >> +}
> >> +
> >> +run_mce_case()
> >> +{
> >> +	local name="$1"
> >> +	local status="$2"
> >> +	local bank="$3"
> >> +	local expect_alias="$4"
> >> +	local index="$5"
> >> +	local alias_msg bank_msg status_tag
> >> +	local alias_before bank_before
> >> +
> >> +	inject_spa="${inject_spas[$index]}"
> >> +	alias_spa="${alias_spas[$index]}"
> >> +	alias_msg="Offlining aliased SPA address0: $alias_spa"
> >> +	status_tag="${status#0x}"
> >> +	bank_msg="Bank $bank: $status_tag"
> >> +	alias_before="$(dmesg_count "$alias_msg")"
> >> +	bank_before="$(dmesg_count "$bank_msg")"
> >> +
> >> +	inject_mce "$status" "$bank"
> >> +	wait_for_dmesg "$bank_msg" "$bank_before" || err "$LINENO"
> >> +
> >> +	if [[ "$expect_alias" == "yes" ]]; then
> >> +		wait_for_dmesg "$alias_msg" "$alias_before" || err "$LINENO"
> >> +	else
> >> +		(($(dmesg_count "$alias_msg") == alias_before)) || \
> >> +			err "$LINENO"
> >> +	fi
> >> +
> >> +	echo "PASS $name: SPA $inject_spa, alias $alias_spa, bank $bank, alias $expect_alias"
> >> +}
> >> +
> >> +run_intel_mce_cases()
> >> +{
> >> +	run_mce_case "Intel corrected" 0x9c00000000000080 \
> >> +		"$test_bank" no 0
> >> +	run_mce_case "Intel uncorrected" 0xbc00000000000080 \
> >> +		"$test_bank" yes 1
> >> +}
> >> +
> >> +run_amd_mce_cases()
> >> +{
> >> +	# Mirror the full AMD matrix documented with the kernel fix. The two
> >> +	# poison-only records have UC=0 and Deferred=0, so they are not valid
> >> +	# architectural records. Keep them as software-injection robustness
> >> +	# coverage and expect the corrected-error filter to reject them.
> >> +	run_mce_case "AMD plain corrected" 0x9c00000000000080 \
> >> +		"$non_b4_bank" no 0
> >> +	run_mce_case "AMD plain uncorrected" 0xbc00000000000080 \
> >> +		"$non_b4_bank" no 1
> >> +	run_mce_case "AMD poison-only (invalid encoding)" \
> >> +		0x9c00080000000080 "$non_b4_bank" no 2
> >> +	run_mce_case "AMD deferred without poison" 0x9c00100000000080 \
> >> +		"$non_b4_bank" no 3
> >> +	run_mce_case "AMD deferred with poison" 0x9c00180000000080 \
> >> +		"$non_b4_bank" yes 4
> >> +	run_mce_case "AMD uncorrected with poison" 0xbc00080000000080 \
> >> +		"$non_b4_bank" yes 5
> >> +	run_mce_case "AMD bank-4 non-memory poison (invalid encoding)" \
> >> +		0x9c00080000000080 4 no 6
> >> +	run_mce_case "AMD legacy bank-4 corrected DRAM ECC" \
> >> +		0x9c00000000080000 4 no 7
> >> +}
> >> +
> >> +test_mce_alias()
> >> +{
> >> +	local region_json
> >> +
> >> +	[[ "$(uname -m)" == "x86_64" ]] || {
> >> +		mce_skip "x86_64 is required"
> >> +		return 0
> >> +	}
> >> +	command -v lsmem >/dev/null 2>&1 || {
> >> +		mce_skip "lsmem is unavailable"
> >> +		return 0
> >> +	}
> >> +
> >> +	region_json="$(echo "$json" | jq -c --arg region "$region" \
> >> +		'.[] | select(.region == $region)')"
> >> +	region_hpa="$(echo "$region_json" | jq -r '.resource // empty')"
> >> +	region_size="$(echo "$region_json" | jq -r '.size // empty')"
> >> +	elc_size="$(echo "$region_json" | jq -r \
> >> +		'.extended_linear_cache_size // empty')"
> >> +
> >> +	[[ "$region_hpa" =~ ^[0-9]+$ ]] || err "$LINENO"
> >> +	[[ "$region_size" =~ ^[0-9]+$ ]] || err "$LINENO"
> >> +	[[ "$elc_size" =~ ^[0-9]+$ ]] || err "$LINENO"
> >> +	((elc_size > 0x10000 && region_size >= elc_size * 2)) || \
> >> +		err "$LINENO"
> >> +
> >> +	select_mce_parameters || {
> >> +		mce_skip "no supported MCA bank configuration for $vendor"
> >> +		return 0
> >> +	}
> >> +
> >> +	if [[ ! -d /sys/module/mce_inject ]]; then
> >> +		modprobe mce-inject || {
> >> +			mce_skip "mce-inject module is unavailable"
> >> +			return 0
> >> +		}
> >> +		mce_inject_loaded=1
> >> +	fi
> >> +	[[ -d /sys/kernel/debug/mce-inject ]] || {
> >> +		mce_skip "mce-inject debugfs interface is unavailable"
> >> +		return 0
> >> +	}
> >> +
> >> +	find_offline_spas "$test_case_count" || {
> >> +		mce_skip "offline lsmem range lacks enough ELC test addresses"
> >> +		return 0
> >> +	}
> >> +
> >> +	case "$vendor" in
> >> +	GenuineIntel)
> >> +		run_intel_mce_cases
> >> +		;;
> >> +	AuthenticAMD)
> >> +		run_amd_mce_cases
> >> +		;;
> >> +	esac
> >> +
> >> +	echo "CXL ELC MCE validation passed for $vendor: $test_case_count cases"
> >> +}
> >> +
> >>  find_region
> >>  retrieve_info
> >>  compare_sizes
> >>  compare_bases
> >>  
> >> +# Check before injecting the expected machine-check messages.
> >> +check_dmesg "$LINENO"
> >> +test_mce_alias
> >>  check_dmesg "$LINENO"
> >> -modprobe -r cxl_test
> >>
> >> base-commit: 15e932c4e1318a9608ad9b799ad83a32a8b5970d
> >> -- 
> >> 2.43.0
> >>
> 
