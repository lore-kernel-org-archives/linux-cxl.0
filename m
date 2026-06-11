Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D04400E0F;
	Thu, 11 Jun 2026 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191811; cv=none; b=GTrymHMkk0MmiNssqCWzOju5a9lXJKMEOr4yi7KU9hEFfaMNGgeydqi9C9kYLQX9MF2vyG9qh8l9B3NMM7Wwb/WoD+bhiytotXwBTEExwj8LsM2uzqgRjqSJz3ZWK/n+QgjGSVpe0MZTP4jNQZiAeBahhd2eoQmOJD8DlFFOOp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191811; c=relaxed/simple;
	bh=S8jQwa2vKpgcYyGAHOHzaIqd7fz3aO76dF50hamaP+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwPuXHXEtSv6nIOBicZpdc8hUY7QUCqas4KGBEix8m5oTvZQt5foQzAtTOjGyU9t9KeWaT2p+KWxPnCEePsIg80Y2eX25c+PFWw2DX+s4zimLonmQHYNAyjTixPtHdnOZpdcIG0FoUSFJi2u0CsX52SGmw+Yoaag0JodqawfojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIb073fg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIb073fg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781191810; x=1812727810;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S8jQwa2vKpgcYyGAHOHzaIqd7fz3aO76dF50hamaP+E=;
  b=IIb073fgxnFfpjmePmHxa+LzI68YkbmEA/y1ezx5rkGa6myKXlV3yt70
   Y+OXUQQ9NR2o9UjjHbpNHiVzArfbT+9Mid1H19LNaOAmRABAqVqrJGPK8
   +nkERf7miNh1R8F4UQ3AFfhkEvi7t0ZIdFF8UYVGzwkOkUoyU40vBnKVr
   Ib88z5s0NP/dKFFjK0+xFQ29mD1lmp4lZ3b9EolOjilKgqE0JATBUzkac
   shgvkIwcYQXLI4aeTQ9PmxMOFqKcrZoeunVTvhdHlRyFQdvAU+IGEqnHn
   OVzw8oDZ40+GuTLo4hOdVFHm2UUHj3eo6IrqDDGY8Cp3EGVyytD3Qbxwe
   A==;
X-CSE-ConnectionGUID: b5sK0YpSQOqOMvni+QCKBQ==
X-CSE-MsgGUID: SKUxTudGSGa82Of5jPS2mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="92328696"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="92328696"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 08:30:09 -0700
X-CSE-ConnectionGUID: rRYmUUmLShK0Mf0KOP6nfg==
X-CSE-MsgGUID: ChqclEGuTEmvYeCh2FPpbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="242115000"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.105]) ([10.125.110.105])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 08:30:07 -0700
Message-ID: <2ced93f1-9a64-4f61-a831-1ca3018aa3c9@intel.com>
Date: Thu, 11 Jun 2026 08:30:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/mbox: Bound the output payload allocation to mailbox
 payload size
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 djbw@kernel.org
Cc: shiju.jose@huawei.com, ming.li@zohomail.com, alucerop@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, newtonl@nvidia.com,
 kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
References: <20260611094546.31496-1-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260611094546.31496-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/11/26 2:45 AM, Richard Cheng wrote:
> CXL_MEM_SEND_COMMAND bounds the user's in.size to the mailbox payload
> size but leaves out.size unbounded, then cxl_mbox_cmd_ctor() calls
> kvzalloc(out.size). A large out.size drives a huge allocation, even
> above INT_MAX it WARNS and taints, on kernel with panic_on_warn=1, it
> will panic.
> The transport __cxl_pci_mbox_send_cmd() already clamps the response copy
> to min(out.size, payload_size, device len), so the bound buffer is never
> written beyond payload_size. Clamp the allocation to payload_size too,
> matching the RAW path.
> 
> With the following reproducer[1] , we'll get error logs [2].
> [1]:
> """
>         #include <fcntl.h>
>         #include <stdint.h>
>         #include <stdio.h>
>         #include <sys/ioctl.h>
> 
>         #define CXL_MEM_SEND_COMMAND        _IOWR(0xCE, 2, struct cxl_send_comma
>         #define CXL_MEM_COMMAND_ID_IDENTIFY 1
> 
>         struct cxl_send_command {
>                 uint32_t id, flags;
>                 union { struct { uint16_t opcode, rsvd; } raw; uint32_t rsvd; };
>                 uint32_t retval;
>                 struct { uint32_t size, rsvd; uint64_t payload; } in;
>                 struct { uint32_t size, rsvd; uint64_t payload; } out;
>         };
> 
>         int main(void)
>         {
>                 static unsigned char buf[512];
>                 struct cxl_send_command c = {
>                         .id          = CXL_MEM_COMMAND_ID_IDENTIFY, /* any enabl
>                         .out.size    = 0x80000000,                  /* > INT_MAX
>                         .out.payload = (uint64_t)(uintptr_t)buf,
>                 };
>                 int fd = open("/dev/cxl/mem0", O_RDWR);
> 
>                 return ioctl(fd, CXL_MEM_SEND_COMMAND, &c);
>         }
> """
> [2]:
>   [ 3675.127839] ------------[ cut here ]------------
>   [ 3675.127841] WARNING: mm/slub.c:6841 at __kvmalloc_node_noprof+0x534/0x818,
>   CPU#131: cxl_repro_outsi/4668
>   [ 3675.127853] Modules linked in: nft_masq nft_ct nft_reject_ipv4
>   nf_reject_ipv4 nft_reject act_csum cls_u32 sch_htb nft_chain_nat nf_nat
>   nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables bridge stp llc qrtr
>   cfg80211 binfmt_misc nls_iso8859_1 acpi_power_meter nvidia_cspmu acpi_ipmi
>   ipmi_ssif coresight_trbe ipmi_devintf sbsa_gwdt dax_hmem arm_smmuv3_pmu
>   coresight arm_cspmu_module arm_spe_pmu ast nvidia_t410_cmem_latency_pmu
>   nvidia_t410_c2c_pmu ipmi_msghandler cppc_cpufreq mlx5_ib macsec ib_uverbs
>   mlx5_fwctl mlx5_dpll sch_fq_codel dm_multipath nvme_fabrics efi_pstore
>   nfnetlink dmi_sysfs ip_tables x_tables autofs4 ib_core btrfs libblake2b raid10
>   raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
>   raid6_pq raid1 raid0 linear ghash_ce gf128mul sm4_ce_gcm mlx5_core nvme
>   sm4_ce_ccm nvme_core mlxfw sm4_ce tls nvme_keyring igb sm4_ce_cipher sm4
>   arm_smccc_trng i2c_algo_bit nvme_auth psample i2c_tegra aes_neon_bs aes_ce_blk
>   [ 3675.127894] CPU: 131 UID: 0 PID: 4668 Comm: cxl_repro_outsi Tainted: G
>     W           7.1.0-rc7-cxltest #1 PREEMPT(full)
>   [ 3675.127897] Tainted: [W]=WARN
>   [ 3675.127898] Hardware name:  , BIOS buildbrain-gcid-sbios-45820373-12 Fri
>   Jun  5 07:54:44 AM UTC 2026
>   [ 3675.127899] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>   [ 3675.127900] pc : __kvmalloc_node_noprof+0x534/0x818
>   [ 3675.127902] lr : __kvmalloc_node_noprof+0x520/0x818
>   [ 3675.127903] sp : ffff800102c2fb90
>   [ 3675.127903] x29: ffff800102c2fbc0 x28: ffff0001911d5000 x27:
>   d8eaa73777d13b74
>   [ 3675.127905] x26: 0000000000000001 x25: ffffa73777d13b74 x24:
>   0000000000000000
>   [ 3675.127907] x23: 00000000ffffffff x22: 0000000000000dc0 x21:
>   00000000000029c0
>   [ 3675.127908] x20: 0000000000000000 x19: 0000000080000000 x18:
>   ffff800125340040
>   [ 3675.127910] x17: 0000000000000000 x16: 0000000000000000 x15:
>   0000ffffd627bed8
>   [ 3675.127911] x14: 0000000000000000 x13: 0000000000000000 x12:
>   0000000000000000
>   [ 3675.127913] x11: 0000000000000000 x10: 0000000000000000 x9 :
>   0000000000000000
>   [ 3675.127914] x8 : 0000000000000000 x7 : 0000000000000000 x6 :
>   0000000000000000
>   [ 3675.127916] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
>   0000000000000000
>   [ 3675.127917] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
>   000000007fffffff
>   [ 3675.127919] Call trace:
>   [ 3675.127919]  __kvmalloc_node_noprof+0x534/0x818 (P)
>   [ 3675.127921]  cxl_send_cmd+0x514/0x7e0
>   [ 3675.127926]  cxl_memdev_ioctl+0x7c/0xe0
>   [ 3675.127928]  __arm64_sys_ioctl+0x4a4/0xbc8
>   [ 3675.127931]  invoke_syscall.constprop.0+0xac/0x100
>   [ 3675.127934]  do_el0_svc+0x4c/0x100
>   [ 3675.127935]  el0_svc+0x50/0x2b0
>   [ 3675.127938]  el0t_64_sync_handler+0xc0/0x108
>   [ 3675.127940]  el0t_64_sync+0x1b8/0x1c0
>   [ 3675.127942] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 4faf31b43468 ("cxl/mbox: Move mailbox and other non-PCI specific infrastructure to the core")
> Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
> Reviewed-by: Koba Ko <kobak@nvidia.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> 
> Maybe we should consider to put the reproducer into selftests of cxl.

Good idea :) 

> 
> Best regards,
> Richard Cheng.
> ---
>  drivers/cxl/core/mbox.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 7c6c5b7450a5..d9cb02c9f72c 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -380,11 +380,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
>  		}
>  	}
>  
> -	/* Prepare to handle a full payload for variable sized output */
> -	if (out_size == CXL_VARIABLE_PAYLOAD)
> -		mbox_cmd->size_out = cxl_mbox->payload_size;
> -	else
> -		mbox_cmd->size_out = out_size;
> +	mbox_cmd->size_out = min_t(size_t, out_size, cxl_mbox->payload_size);
>  
>  	if (mbox_cmd->size_out) {
>  		mbox_cmd->payload_out = kvzalloc(mbox_cmd->size_out, GFP_KERNEL);
> 
> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48

