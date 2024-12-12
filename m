Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA88315696E
	for <linux-cxl@vger.kernel.org>; Thu, 12 Dec 2024 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025225; cv=none; b=nMAF2j9Bc31GhRBi3iujVFGhQYymQVgeqHuKj2dscHBow8xxMdPrxTauleVbqJpmkJx9KcZC3DZZF0Ns8WV3gDOXpdLO5IYei9iaBCpv1iCHE/+ebYVMK8nHQW0G8u0dbpWvw832DoIL9k/LxzOxNV0qF6SarpJFmhkZXv9U96k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025225; c=relaxed/simple;
	bh=WXf9QBvaIUs3RcZua58dDjr9vgu0VbPOwhENJCbCA3s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h31j28Rz65bozemPohFFKiGy6rhaVVw4qoWWvAi/p0wZPlBLt6RcLecUjt/FZpkCMZ1SffOJYgCjoAbNSmW+UB2A6Jj+sn8YmeK536vh8l4WnKx6i5IU8Ptij8Ak5AT4kpgWZDdzjVbw96LV6kGaTL7pYKoBaYdMFzaylPP8yO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y8KQz3vhrz6K99S;
	Fri, 13 Dec 2024 01:36:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 45CB2140A86;
	Fri, 13 Dec 2024 01:40:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Dec
 2024 18:40:18 +0100
Date: Thu, 12 Dec 2024 17:40:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>,
	<svetly.todorov@memverge.com>, <nifan.cxl@gmail.com>
Subject: Re: [PATCH RFC v3 3/3] mhsld: implement MHSLD device
Message-ID: <20241212174016.0000002a@huawei.com>
In-Reply-To: <20241018161252.8896-4-gourry@gourry.net>
References: <20241018161252.8896-1-gourry@gourry.net>
	<20241018161252.8896-4-gourry@gourry.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 18 Oct 2024 12:12:52 -0400
Gregory Price <gourry@gourry.net> wrote:

> From: Svetly Todorov <svetly.todorov@memverge.com>
> 
> Using a shared-memory bytemap, validates that DC adds, releases,
> and reclamations happen on extents belonging to the appropriate
> host.
> 
> The MHSLD device inherits from the CXL_TYPE3 class and adds the following
> configuration options:

As in previous the -- syntax is somewhat confusing as that's
not how the parameters are applied.

> --mhd-head=<u32>
> --mhd-state_file=<str>
> --mhd-init=<bool>
> 
> --mhd-head specifies the head ID of the host on the given device.
> 
> --mhd-state_file is the name of the shared-memory-backed file used
> to store the MHD state.
> 
> --mhd-init indicates whether this QEMU instance should initialize
> the state_file; if so, the instance will create the file if it does
> not exist, ftruncate it to the appropriate size, and initialize its
> header. It is assumed that the --mhd-init instance is run and allowed
> to completely finish configuration before any other guests access the
> shared state.
> 
> The shared state file only needs to be intialized once. Even if a guest
> dies without clearing the ownership bits associated with its head-ID,
> future guests with that ID will clear those bits in cxl_mhsld_realize(),
> regardless of whether mhd_init is true or false.

That sounds like a race condition if not all hosts are brought
up before the first add.

> 
> The following command line options create an MHSLD with 4GB of
> backing memory, whose state is tracked in /dev/shm/mhd_metadata.
> --mhd-init=true tells this instance to initialize the state as
> described above.
> 
> ./qemu-system_x86-64 \
> [... other options ...] \
> -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
> -object memory-backend-ram,id=mem0,size=4G \
> -device cxl-mhsld,bus=rp0,num-dc-regions=1,volatile-dc-memdev=mem0,id=cxl-mem0,sn=66667,mhd-head=0,mhd-state_file=mhd_metadata,mhd-init=true \
> -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G \
> -qmp unix:/tmp/qmp-sock-1,server,nowait
> 
> Once this guest completes setup, other guests looking to access the
> device can be booted with the same configuration options, but with
> --mhd-head != 0,
> --mhd-init=false,
> and a different QMP socket.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Svetly Todorov <svetly.todorov@memverge.com>

A few trivial things inline.

In general the scheme looks workable but I'm not sure the contraints at setup time
etc are suitable for an upstream solution.  Certainly a useful tool to have
for kernel development though so I'll try and find time in next few days to apply
this on my gitlab tree.

Longer term I think we need a more complex external program or a main / proxy
type arrangement so that ordering requirements can be enforce and we can have
richer info.  Having to chat to each qmp interface independently works fine is
also a bit more complex than I think we would eventually want.

Having a solution in place though will make it much easier to move towards
an eventual upstreamable solution. This is a great place to start from!

Jonathan

> +static bool cxl_mhsld_release_extent(PCIDevice *d, uint64_t dpa, uint64_t len)
> +{
> +    cxl_mhsld_state_clear(CXL_MHSLD(d), dpa / MHSLD_BLOCK_SZ,
> +        len / MHSLD_BLOCK_SZ);

Trivial but align after (

> +    return true;
> +}


> diff --git a/hw/cxl/mhsld/mhsld.h b/hw/cxl/mhsld/mhsld.h
> new file mode 100644
> index 0000000000..e7ead1f0d2
> --- /dev/null
> +++ b/hw/cxl/mhsld/mhsld.h
> @@ -0,0 +1,75 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (c) 2024 MemVerge Inc.
> + *
> + */
> +
> +#ifndef CXL_MHSLD_H
> +#define CXL_MHSLD_H
> +#include <stdint.h>
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_mailbox.h"
> +#include "hw/cxl/cxl_device.h"
> +#include "qemu/units.h"
> +
> +#define MHSLD_BLOCK_SZ (2 * MiB)
> +
> +/*
> + * We limit the number of heads to prevent the shared state
> + * region from becoming a major memory hog.  We need 512MB of
> + * memory space to track 8-host ownership of 4GB of memory in
> + * blocks of 2MB.  This can change if the block size is increased.

I'm lost what makes up that size?


 
> + */
> +#define MHSLD_HEADS  (8)
> +
> +/*
> + * The shared state cannot have 2 variable sized regions
> + * so we have to max out the ldmap.
> + */
> +typedef struct MHSLDSharedState {
> +    uint8_t nr_heads;
> +    uint8_t nr_lds;
> +    uint8_t ldmap[MHSLD_HEADS];
> +    uint64_t nr_blocks;
> +    uint8_t blocks[];
> +} MHSLDSharedState;
> +
> +struct CXLMHSLDState {
> +    CXLType3Dev ct3d;
> +    bool mhd_init;
> +    char *mhd_state_file;
> +    int mhd_state_fd;
> +    size_t mhd_state_size;
> +    uint32_t mhd_head;
> +    MHSLDSharedState *mhd_state;
> +};
> +
> +struct CXLMHSLDClass {
> +    CXLType3Class parent_class;
> +};
> +
> +enum {
> +    MHSLD_MHD = 0x55,
> +        #define GET_MHD_INFO 0x0
> +};
> +
> +/*
> + * MHD Get Info Command
> + * Returns information the LD's associated with this head
> + */
> +typedef struct MHDGetInfoInput {
> +    uint8_t start_ld;
> +    uint8_t ldmap_len;
> +} QEMU_PACKED MHDGetInfoInput;
> +
> +typedef struct MHDGetInfoOutput {
> +    uint8_t nr_lds;
> +    uint8_t nr_heads;
> +    uint16_t resv1;
> +    uint8_t start_ld;
> +    uint8_t ldmap_len;
> +    uint16_t resv2;
> +    uint8_t ldmap[];
> +} QEMU_PACKED MHDGetInfoOutput;
> +#endif

