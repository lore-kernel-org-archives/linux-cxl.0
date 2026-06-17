Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF473F8EB3;
	Wed, 17 Jun 2026 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.212.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781731052; cv=none; b=Ic32NYhp+V87CglSb42hflZPdL5FhIjXd1bkLRdi7jVY70LKXI5bzyum2zNNjouiu25+ZT3FN9P/Vi51LAw2HR1XmoTCQxP3bzBxdGjMNhpJ8MDUut/U3ugRCJY9p5mlXk/baLyaDmhWHB68Ix9HO9Y3NJtocJHptW33V0jz4kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781731052; c=relaxed/simple;
	bh=BxKm2lUZtFLbPvvvBNd2UiZNba5ze3AmI4ggBwWeLAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPWrf95SF8VxqfCJSGv2ZAJDEprGQCgiehLpI97NRtik8csOtexZttSH9406xCc7BjgEOlSwXZqm37yynWl6M8vjMjvTNvvrL0N9RJXf+Hin+YrjgxjFlAMsjRj+pPHUREqSjRAhIbpVEOwdyuYIIs7+V5kds5VXJvhMYd/NH0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=bX3T1Dm5; arc=none smtp.client-ip=23.83.212.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="bX3T1Dm5"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 204E83815C9;
	Wed, 17 Jun 2026 21:07:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a230.dreamhost.com (100-96-9-130.trex-nlb.outbound.svc.cluster.local [100.96.9.130])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A17993813BC;
	Wed, 17 Jun 2026 21:07:51 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Befitting-Tart: 1781dd1b22e67ec1_1781730471970_188924871
X-MC-Loop-Signature: 1781730471970:4198865853
X-MC-Ingress-Time: 1781730471970
Received: from pdx1-sub0-mail-a230.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.9.130 (trex/7.1.5);
	Wed, 17 Jun 2026 21:07:51 +0000
Received: from offworld (unknown [148.222.205.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a230.dreamhost.com (Postfix) with ESMTPSA id 4ggbzS13qpz38;
	Wed, 17 Jun 2026 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1781730471;
	bh=RwUIUzhkl++Fa51/5JpfM5gXfnD2dh3OwMdESbRVa/I=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=bX3T1Dm5fZl4E/7WqNoDF+605bZ4uzpg5vKHBGDYjwwmw4TA131gkOmvPuitH8ER6
	 g0PKoV3fCfaUPx/PaSOKAnXyE9hlailOhUnjXQw2iWhA6O3DO3RSFCla2SRlfK5ga1
	 CY2QugELL7oIkwBPKvzKRH3uHut/amY6hOg68XWA6X+47z+ONzuI7usiz0LvjrpiW3
	 4eZpNLZnITW/d9vlANiTFi4Md6OvVuik5QnIO65emp0t9mPmbw72xEkoWXpCbK8NwM
	 W3QC2fUmJIPSUSxpTcWz8YR0q+dQq/zF0OUm5YbaH871kULXKOWSJi+U+Z2xBtbbDo
	 dU2ZIAB7p9n8w==
Date: Wed, 17 Jun 2026 14:07:45 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: jic23@kernel.org, dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org,
	shiju.jose@huawei.com, ming.li@zohomail.com, alucerop@amd.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com,
	kobak@nvidia.com
Subject: Re: [PATCH] cxl/mbox: Bound the output payload allocation to mailbox
 payload size
Message-ID: <20260617210745.55uzogugkcjbosp7@offworld>
References: <20260611094546.31496-1-icheng@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260611094546.31496-1-icheng@nvidia.com>
User-Agent: NeoMutt/20220429

On Thu, 11 Jun 2026, Richard Cheng wrote:

>CXL_MEM_SEND_COMMAND bounds the user's in.size to the mailbox payload
>size but leaves out.size unbounded, then cxl_mbox_cmd_ctor() calls
>kvzalloc(out.size). A large out.size drives a huge allocation, even
>above INT_MAX it WARNS and taints, on kernel with panic_on_warn=1, it
>will panic.
>The transport __cxl_pci_mbox_send_cmd() already clamps the response copy
>to min(out.size, payload_size, device len), so the bound buffer is never
>written beyond payload_size. Clamp the allocation to payload_size too,
>matching the RAW path.
>
>With the following reproducer[1] , we'll get error logs [2].
>[1]:
>"""
>        #include <fcntl.h>
>        #include <stdint.h>
>        #include <stdio.h>
>        #include <sys/ioctl.h>
>
>        #define CXL_MEM_SEND_COMMAND        _IOWR(0xCE, 2, struct cxl_send_comma
>        #define CXL_MEM_COMMAND_ID_IDENTIFY 1
>
>        struct cxl_send_command {
>                uint32_t id, flags;
>                union { struct { uint16_t opcode, rsvd; } raw; uint32_t rsvd; };
>                uint32_t retval;
>                struct { uint32_t size, rsvd; uint64_t payload; } in;
>                struct { uint32_t size, rsvd; uint64_t payload; } out;
>        };
>
>        int main(void)
>        {
>                static unsigned char buf[512];
>                struct cxl_send_command c = {
>                        .id          = CXL_MEM_COMMAND_ID_IDENTIFY, /* any enabl
>                        .out.size    = 0x80000000,                  /* > INT_MAX
>                        .out.payload = (uint64_t)(uintptr_t)buf,
>                };
>                int fd = open("/dev/cxl/mem0", O_RDWR);
>
>                return ioctl(fd, CXL_MEM_SEND_COMMAND, &c);
>        }

Nit: Maybe not needed in the changelog.

>"""
>[2]:
>  [ 3675.127839] ------------[ cut here ]------------
>  [ 3675.127841] WARNING: mm/slub.c:6841 at __kvmalloc_node_noprof+0x534/0x818,
>  CPU#131: cxl_repro_outsi/4668
>  [ 3675.127853] Modules linked in: nft_masq nft_ct nft_reject_ipv4
>  nf_reject_ipv4 nft_reject act_csum cls_u32 sch_htb nft_chain_nat nf_nat
>  nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables bridge stp llc qrtr
>  cfg80211 binfmt_misc nls_iso8859_1 acpi_power_meter nvidia_cspmu acpi_ipmi
>  ipmi_ssif coresight_trbe ipmi_devintf sbsa_gwdt dax_hmem arm_smmuv3_pmu
>  coresight arm_cspmu_module arm_spe_pmu ast nvidia_t410_cmem_latency_pmu
>  nvidia_t410_c2c_pmu ipmi_msghandler cppc_cpufreq mlx5_ib macsec ib_uverbs
>  mlx5_fwctl mlx5_dpll sch_fq_codel dm_multipath nvme_fabrics efi_pstore
>  nfnetlink dmi_sysfs ip_tables x_tables autofs4 ib_core btrfs libblake2b raid10
>  raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
>  raid6_pq raid1 raid0 linear ghash_ce gf128mul sm4_ce_gcm mlx5_core nvme
>  sm4_ce_ccm nvme_core mlxfw sm4_ce tls nvme_keyring igb sm4_ce_cipher sm4
>  arm_smccc_trng i2c_algo_bit nvme_auth psample i2c_tegra aes_neon_bs aes_ce_blk
>  [ 3675.127894] CPU: 131 UID: 0 PID: 4668 Comm: cxl_repro_outsi Tainted: G
>    W           7.1.0-rc7-cxltest #1 PREEMPT(full)
>  [ 3675.127897] Tainted: [W]=WARN
>  [ 3675.127898] Hardware name:  , BIOS buildbrain-gcid-sbios-45820373-12 Fri
>  Jun  5 07:54:44 AM UTC 2026
>  [ 3675.127899] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>  [ 3675.127900] pc : __kvmalloc_node_noprof+0x534/0x818
>  [ 3675.127902] lr : __kvmalloc_node_noprof+0x520/0x818
>  [ 3675.127903] sp : ffff800102c2fb90
>  [ 3675.127903] x29: ffff800102c2fbc0 x28: ffff0001911d5000 x27:
>  d8eaa73777d13b74
>  [ 3675.127905] x26: 0000000000000001 x25: ffffa73777d13b74 x24:
>  0000000000000000
>  [ 3675.127907] x23: 00000000ffffffff x22: 0000000000000dc0 x21:
>  00000000000029c0
>  [ 3675.127908] x20: 0000000000000000 x19: 0000000080000000 x18:
>  ffff800125340040
>  [ 3675.127910] x17: 0000000000000000 x16: 0000000000000000 x15:
>  0000ffffd627bed8
>  [ 3675.127911] x14: 0000000000000000 x13: 0000000000000000 x12:
>  0000000000000000
>  [ 3675.127913] x11: 0000000000000000 x10: 0000000000000000 x9 :
>  0000000000000000
>  [ 3675.127914] x8 : 0000000000000000 x7 : 0000000000000000 x6 :
>  0000000000000000
>  [ 3675.127916] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
>  0000000000000000
>  [ 3675.127917] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
>  000000007fffffff
>  [ 3675.127919] Call trace:
>  [ 3675.127919]  __kvmalloc_node_noprof+0x534/0x818 (P)
>  [ 3675.127921]  cxl_send_cmd+0x514/0x7e0
>  [ 3675.127926]  cxl_memdev_ioctl+0x7c/0xe0
>  [ 3675.127928]  __arm64_sys_ioctl+0x4a4/0xbc8
>  [ 3675.127931]  invoke_syscall.constprop.0+0xac/0x100
>  [ 3675.127934]  do_el0_svc+0x4c/0x100
>  [ 3675.127935]  el0_svc+0x50/0x2b0
>  [ 3675.127938]  el0t_64_sync_handler+0xc0/0x108
>  [ 3675.127940]  el0t_64_sync+0x1b8/0x1c0
>  [ 3675.127942] ---[ end trace 0000000000000000 ]---

My cxl syzkaller also ran into this issue and I had a similar patch
I never sent out.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>
>Fixes: 4faf31b43468 ("cxl/mbox: Move mailbox and other non-PCI specific infrastructure to the core")
>Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
>Reviewed-by: Koba Ko <kobak@nvidia.com>
>Signed-off-by: Richard Cheng <icheng@nvidia.com>
>---
