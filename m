Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4FE3588D
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6HrXoxA"
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C35EB0
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 10:10:16 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc3542e328so41708725ad.1
        for <linux-cxl@vger.kernel.org>; Tue, 07 Nov 2023 10:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699380616; x=1699985416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=872NT2jnFhG8wm8+lD3t3/U5wszznBHMhw38Vv5CsDA=;
        b=P6HrXoxAnPPEjmiTAcsRBez7Chb2KQBtmjcoOKZ/IwgUZtwSfY6l7OJXa0TBwCUxiM
         190jL7FuObcXoNUhYEBma+esBVIJg5fVorziUbw9uedpHcdiXHPm6PoYE7XbNcb/iPxT
         Qyd163HiLW7aNFHnbbfWw1N0kc4h6PqOPPAGzPvgyc/2+1ln1D+XtoLZU1hrrWn80z12
         Jg5Kh/ELGOGHzwQo49/WZp4vcxtIz3f4MnMwZz8Y5ify8DxAA4fnCKGdjGZ/ONqoKPET
         GjdGehPPwK5DX+VPYB3H2S65jtDlwzWh16aO0g9n/yD6Rkk6ffh98ZLPH1EhFTMOhYNv
         jZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380616; x=1699985416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=872NT2jnFhG8wm8+lD3t3/U5wszznBHMhw38Vv5CsDA=;
        b=SviI4+mk7gNUk6/xcu1K/iZe0BPfc/ESKkTMz6vJUBf4F9GwVLsSXx3YmuPG3T1MqP
         3ro7EgRzm/hI+h0SWavT0mU5s87dQl9AHxjPyjpj7rZbVNt3/Qv30vVDU2ygc9WPQmGs
         Dky4X9edvcH8ceFFIQx+E1B4m6rkQ69sQiC72IViXw48ecT8X52SkmaqBVs5NiLajjtU
         jaXgNPfYcwTmAIjC4x6o4RgslSkzun8ilLej28qXt28kfvUT1T5fXMJoZFNJuoDv8fnK
         4QuR/MYLDGUXHWVD25D5PNd+pkSek5IluG8Ckza0wwbHfPHuRByILt5iHlc53OTHPUPg
         nc7A==
X-Gm-Message-State: AOJu0YyoYpzpxHY9aW0HrafWiWEsS4pVwf1uo5qEIafwRTAJBy3mN9CI
	iYHTuDSTJq7Eat5SzhvT74o=
X-Google-Smtp-Source: AGHT+IGpDAZuTY89vqYjA1pQEMeZEpOFC5R0rLXifr2HHa+PlrsdY39ctuA83JReZ0sT3cFCfOZqjQ==
X-Received: by 2002:a17:903:124a:b0:1cc:ee07:1659 with SMTP id u10-20020a170903124a00b001ccee071659mr4218910plh.46.1699380615908;
        Tue, 07 Nov 2023 10:10:15 -0800 (PST)
Received: from DT.local (c-71-202-158-162.hsd1.ca.comcast.net. [71.202.158.162])
        by smtp.gmail.com with ESMTPSA id az10-20020a170902a58a00b001cc615e6850sm131924plb.90.2023.11.07.10.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:10:15 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan@outlook.com,
	jim.harris@samsung.com,
	Fan Ni <nifan.cxl@gmail.com>
Subject: [PATCH v3 0/9] Enabling DCD emulation support in Qemu
Date: Tue,  7 Nov 2023 10:07:04 -0800
Message-ID: <20231107180907.553451-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <nifan.cxl@gmail.com>


The patch series are based on Jonathan's branch cxl-2023-09-26.

The main changes include,
1. Update cxl_find_dc_region to detect the case the range of the extent cross
    multiple DC regions.
2. Add comments to explain the checks performed in function
    cxl_detect_malformed_extent_list. (Jonathan)
3. Minimize the checks in cmd_dcd_add_dyn_cap_rsp.(Jonathan)
4. Update total_extent_count in add/release dynamic capacity response function.
    (Ira and Jorgen Hansen).
5. Fix the logic issue in test_bits and renamed it to
    test_any_bits_set to clear its function.
6. Add pending extent list for dc extent add event.
7. When add extent response is received, use the pending-to-add list to
    verify the extents are valid.
8. Add test_any_bits_set and cxl_insert_extent_to_extent_list declaration to
    cxl_device.h so it can be used in different files.
9. Updated ct3d_qmp_cxl_event_log_enc to include dynamic capacity event
    log type.
10. Extract the functionality to delete extent from extent list to a helper
    function.
11. Move the update of the bitmap which reflects which blocks are backed with
dc extents from the moment when a dc extent is offered to the moment when it
is accepted from the host.
12. Free dc_name after calling address_space_init to avoid memory leak when
    returning early. (Nathan)
13. Add code to detect and reject QMP requests without any extents. (Jonathan)
14. Add code to detect and reject QMP requests where the extent len is 0.
15. Change the QMP interface and move the region-id out of extents and now
    each command only takes care of extent add/release request in a single
    region. (Jonathan)
16. Change the region bitmap length from decode_len to len.
17. Rename "dpa" to "offset" in the add/release dc extent qmp interface.
    (Jonathan)
18. Block any dc extent release command if the exact extent is not already in
    the extent list of the device.

The code is tested together with Ira's kernel DCD support:
https://github.com/weiny2/linux-kernel/tree/dcd-v3-2023-10-30

Cover letter from v2 is here:
https://lore.kernel.org/linux-cxl/20230724162313.34196-1-fan.ni@samsung.com/T/#m63039621087023691c9749a0af1212deb5549ddf

Last version (v2) is here:
https://lore.kernel.org/linux-cxl/20230725183939.2741025-1-fan.ni@samsung.com/

More DCD related discussions are here:
https://lore.kernel.org/linux-cxl/650cc29ab3f64_50d07294e7@iweiny-mobl.notmuch/



Fan Ni (9):
  hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
    payload of identify memory device command
  hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
    and mailbox command support
  include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
    type3 memory devices
  hw/mem/cxl_type3: Add support to create DC regions to type3 memory
    devices
  hw/mem/cxl_type3: Add host backend and address space handling for DC
    regions
  hw/mem/cxl_type3: Add DC extent list representative and get DC extent
    list mailbox support
  hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
    dynamic capacity response
  hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
    extents
  hw/mem/cxl_type3: Add dpa range validation for accesses to dc regions

 hw/cxl/cxl-mailbox-utils.c  | 469 +++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 548 +++++++++++++++++++++++++++++++++---
 hw/mem/cxl_type3_stubs.c    |  14 +
 include/hw/cxl/cxl_device.h |  64 ++++-
 include/hw/cxl/cxl_events.h |  15 +
 qapi/cxl.json               |  60 +++-
 6 files changed, 1123 insertions(+), 47 deletions(-)

-- 
2.42.0

