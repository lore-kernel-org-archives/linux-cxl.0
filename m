Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7685FF05
	for <linux-cxl@vger.kernel.org>; Tue, 13 Feb 2024 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848311; cv=none; b=Yxf8zAfJKWQnxfzh1khk9olznR3G1E+46OZg9mwJhC+lWWjCNkkuPFZ2JT6uW+gXG5hulXEI5wdBXchvvha7IsRZZwTn8sOqevEjlPgZmSfXb/hivWdFMmYPQSP2lrzf33n4/l0TbRl6HV1B2O4O64t8zAKiIZv5I7/chf3sCQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848311; c=relaxed/simple;
	bh=/94sQNmhJZOqU1Deays+JPjZ8uxIBG/qVbmy5sef5qg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEvDnbkIvtGDlAt2zwpGunKolsmSGNET9H2Kk0Vz7qJkfvbprdztAD0/4wOBy1tZhw63hRSddwaqu4dnQmd0MLZjanlexUIpFcwFePzBuf1BOkKPeL0aNGd73aGIbsNSOi6qN5oUhPFRhZXWpxyfKycUm/hQujU4mEHymQ0KSjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XM1ouY1O; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM1ouY1O"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d73066880eso42914805ad.3
        for <linux-cxl@vger.kernel.org>; Tue, 13 Feb 2024 10:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707848309; x=1708453109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dw1mjwm2smp4j4HULN2r42PjqzSt3X4acORkoaFVbpE=;
        b=XM1ouY1O8EabgDG/WQhf4nJVr9bh5nqnsMKX9pgZmludpTDJLpPUdm6/DXUjx8hDwm
         bisdOKoZYqdbaA9r7PZ0M2p8+DpuLJqTU+uEy96asUNlJEZaJqSyGWymeeYhm00uGiyi
         +RSAfH/+zRSRAgidsqOmAhXsz/x8ck7n1sT/nGG288SzFkATfFVJ+JUDs0rkrTShIZm7
         wqney2se83hoZ+UAG4/yXrBxhSvBu8H5F4oO9n/DOVOZYeS/wWlleBV0KixnvWfSqiqo
         /9vYDi9qK/K97lZk/QNNXhizRPzuPZjERH6ULWngoekfplEVZQswb6nIPexPB1w/KNBF
         agkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707848309; x=1708453109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dw1mjwm2smp4j4HULN2r42PjqzSt3X4acORkoaFVbpE=;
        b=aSIpoCiYrAgbTPN5TVmVTqXfRy6k4qakXyN5gMmJ5C5fW14NRd6QPyUjN6+KaPfk8A
         j/7rC5eBR60gz99INJ14qSg6cVZHex7bsfLlUrGXdG33iif0So0z15uxKRoT5e3pnkTx
         aN1QsoebsA6CPzvU3AY47Ys3GZ6I7S7KNoMpzODMV9Awndw6Mdnbyw9LD3N7q/s0rXil
         Sr+4vt9emum2nM+ECdVgoyTvrzbUip3rWa5TWN2iO2xISf/q5425bIafez6l6NI4S+BZ
         8/Ig3OLX0uglAyXr4+AY6CzzQeJHjhrBBQJJZfxDOcxz+W7jy6/cPc7Sbs1d/pXSJIUv
         LgJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMno3eFhabzlfmcwlh2rsWFpyQEbkBj+w6k87X4iNWYzpKeIYvlp+nvQCHAPF0NhoTzJNntHYDOw4mL96Ae8L7l3kilPup0ZY1
X-Gm-Message-State: AOJu0YzMlsAML0yPSjdE2j8vmFV9lPf20oIK+J54Cd2y6Zu1Qkt8ch/9
	pxw7OjzymFsZAKL8JMAZ8+M/1Lpui23BCYe036a/XYDshuWuMMkh
X-Google-Smtp-Source: AGHT+IG9/kMEFLB0OUl6JspBcOGju3LDNSCg476qjmKrKGdhfHdQGnW3U53QHES9vNaZkZHc/xtTGg==
X-Received: by 2002:a17:902:fc50:b0:1d6:c8e3:c3dd with SMTP id me16-20020a170902fc5000b001d6c8e3c3ddmr378651plb.54.1707848308714;
        Tue, 13 Feb 2024 10:18:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpQWl787Jfsk2qDxgtPYf1bjzf748qAygyucoz2GVmA8PIeHvTTXpRQOz0daglx3MQjHvwvMkOkL+INMqYz1A2BXCgHOeNjcy8IKpHDGJseDwQEYC+X651eVL3DN5ZUKV5U6w4Bc03AGWrXH1Y/rOzXZ9OlVhBvrhmQVMRVNoYZS/gN4bD3VT57hDUkm2TRqzSbYHoZWuAMHEvuPOkOpY+xGt74GSHPkalroeRJkU9Y+k0x+bdpW0kZVbXnkG6wTj/7N5dC6+0LVy+ae4kv5gMd9x005v4S2MEbbnUw4UISzDF1Pb0vaabSjWtDVDtpMd4poL2mrxfOolObcBy5ywMVouaFPQ5Sak=
Received: from debian ([2601:641:300:14de:a8fd:e6e0:547f:c54a])
        by smtp.gmail.com with ESMTPSA id mm3-20020a1709030a0300b001d944b3c5f1sm2377828plb.178.2024.02.13.10.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:18:28 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 13 Feb 2024 10:18:15 -0800
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan@outlook.com,
	jim.harris@samsung.com
Subject: Re: [PATCH v3 0/9] Enabling DCD emulation support in Qemu
Message-ID: <ZcuyZ0Nwq31z8YIr@debian>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107180907.553451-1-nifan.cxl@gmail.com>

On Tue, Nov 07, 2023 at 10:07:04AM -0800, nifan.cxl@gmail.com wrote:
> From: Fan Ni <nifan.cxl@gmail.com>
> 
> 
> The patch series are based on Jonathan's branch cxl-2023-09-26.
> 
> The main changes include,
> 1. Update cxl_find_dc_region to detect the case the range of the extent cross
>     multiple DC regions.
> 2. Add comments to explain the checks performed in function
>     cxl_detect_malformed_extent_list. (Jonathan)
> 3. Minimize the checks in cmd_dcd_add_dyn_cap_rsp.(Jonathan)
> 4. Update total_extent_count in add/release dynamic capacity response function.
>     (Ira and Jorgen Hansen).
> 5. Fix the logic issue in test_bits and renamed it to
>     test_any_bits_set to clear its function.
> 6. Add pending extent list for dc extent add event.
> 7. When add extent response is received, use the pending-to-add list to
>     verify the extents are valid.
> 8. Add test_any_bits_set and cxl_insert_extent_to_extent_list declaration to
>     cxl_device.h so it can be used in different files.
> 9. Updated ct3d_qmp_cxl_event_log_enc to include dynamic capacity event
>     log type.
> 10. Extract the functionality to delete extent from extent list to a helper
>     function.
> 11. Move the update of the bitmap which reflects which blocks are backed with
> dc extents from the moment when a dc extent is offered to the moment when it
> is accepted from the host.
> 12. Free dc_name after calling address_space_init to avoid memory leak when
>     returning early. (Nathan)
> 13. Add code to detect and reject QMP requests without any extents. (Jonathan)
> 14. Add code to detect and reject QMP requests where the extent len is 0.
> 15. Change the QMP interface and move the region-id out of extents and now
>     each command only takes care of extent add/release request in a single
>     region. (Jonathan)
> 16. Change the region bitmap length from decode_len to len.
> 17. Rename "dpa" to "offset" in the add/release dc extent qmp interface.
>     (Jonathan)
> 18. Block any dc extent release command if the exact extent is not already in
>     the extent list of the device.
> 
> The code is tested together with Ira's kernel DCD support:
> https://github.com/weiny2/linux-kernel/tree/dcd-v3-2023-10-30
> 
> Cover letter from v2 is here:
> https://lore.kernel.org/linux-cxl/20230724162313.34196-1-fan.ni@samsung.com/T/#m63039621087023691c9749a0af1212deb5549ddf
> 
> Last version (v2) is here:
> https://lore.kernel.org/linux-cxl/20230725183939.2741025-1-fan.ni@samsung.com/
> 
> More DCD related discussions are here:
> https://lore.kernel.org/linux-cxl/650cc29ab3f64_50d07294e7@iweiny-mobl.notmuch/
> 
> 
> 
> Fan Ni (9):
>   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
>     payload of identify memory device command
>   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
>     and mailbox command support
>   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
>     type3 memory devices
>   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
>     devices
>   hw/mem/cxl_type3: Add host backend and address space handling for DC
>     regions
>   hw/mem/cxl_type3: Add DC extent list representative and get DC extent
>     list mailbox support
>   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
>     dynamic capacity response
>   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
>     extents
>   hw/mem/cxl_type3: Add dpa range validation for accesses to dc regions
> 
>  hw/cxl/cxl-mailbox-utils.c  | 469 +++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          | 548 +++++++++++++++++++++++++++++++++---
>  hw/mem/cxl_type3_stubs.c    |  14 +
>  include/hw/cxl/cxl_device.h |  64 ++++-
>  include/hw/cxl/cxl_events.h |  15 +
>  qapi/cxl.json               |  60 +++-
>  6 files changed, 1123 insertions(+), 47 deletions(-)
> 
> -- 
> 2.42.0
> 

Hi Jonathan,

I have updated the patch set based on your feedback and aligned the code
to cxl spec r3.1.

Here is the new code:
https://github.com/moking/qemu/tree/dcd-v4

I plan to send it out for review early next week to see if there is any kernel
side update for dcd this week so I can test more.

If the plan needs to be adjusted to align with the merge window, please
let me know.

v3[1]->v4: 

The code is rebased on mainstream QEMU with the following patch series:

[PATCH 00/12 qemu] CXL emulation fixes and minor cleanup.
[PATCH 0/5 qemu] hw/cxl: Update CXL emulation to reflect and reference r3.1
hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference
hw/cxl/mailbox: interface to add CCI commands to an existing CCI

Main changes include:

1. Updated the specification references to align with cxl spec r3.1.
2. Add extra elements to get dc region configuration output payload and
procecced accordingly in mailbox command 4800h.
3. Removed the unwanted space.
4. Refactored ct3_build_cdat_entries_for_mr and extract it as a separate patch.
5. Updated cxl_create_dc_regions function to derive region len from host
backend size.
6. Changed the logic for creating DC regions when host backend and address
space processing is introduced, now cxl_create_dc_regions is called only
when host backend exists.
7. Updated the name of the definitions related to DC extents for consistency.
7. Updated dynamic capacity event record definition to align with spec r3.1.
9. Changed the dynamic capacity request process logic, for release request,
extra checks are done against the pending list to remove the extent yet added.
10. Changed the return value of cxl_create_dc_regions so the return can be used
to remove the extent for the list if needed.
11. Offset and size in the qmp interface are changed to be byte-wise while the
original is MiB-wise.
12. Fixed bugs in handling bitmap for dpa range existence.
13. NOTE: in previous version DC is set to non-volatile, while in this version
we change it to volatile per Jonathan's suggestion.
14. Updated the doc in qapi/cxl.json.

Thank Jonathan for the detailed review of the last version[1].

The code is tested with Ira's last kernel DCD patch set [2] with some minor
bug fixes[3]. Tested operations include:
1. create DC region;
2. Add/release DC extents;
3. convert DC capacity into system RAM;


v3: 
[1] https://lore.kernel.org/linux-cxl/20231107180907.553451-1-nifan.cxl@gmail.com/T/#t
[2] https://github.com/weiny2/linux-kernel/tree/dcd-v3-2023-10-30
[3] https://github.com/moking/linux-dcd/commit/9d24fa6e5d39f934623220953caecc080f93e964
