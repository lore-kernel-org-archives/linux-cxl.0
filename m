Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B63D81AA7
	for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486519; cv=none; b=otC1xAnj1rC+695afCAMhu5zIV0+hSwwgH2sPcfcHqtf35enFfuQuH566Q5m6hOfO0p9bkDwwpbSJx5DV5VA2zzptea0fifIktlRIIxQnaIHMbvNmj2FtqbaHT3To2EfugUpAgxN9ipoZEgNiQnwMB/2p9glhPrPkIwmjm+NVKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486519; c=relaxed/simple;
	bh=MeCd6cRYmG4QFIMfetx4vhCLgN99sRS1YyuzbxvAlBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9dvFkuYrJnHLVgxcSxklSjc/Iw6aphNqesMYVbMkQ9VlB4IK+Ej8J7nNpJYiRgfnwDg63hsol0sxyu36G3aMY9cune7pIGfXEDCNkSzHFAO1qjkPCtgkYjYt5J8GPMcrTBHt3QObaHx8mamOy6M2NTgYtQ0aa2URdnGZmIS/HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFUHvof4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFUHvof4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ee954e0aa6so22520865ad.3
        for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 10:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486518; x=1717091318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4r6TCjebwmoal19hsNaIlox9kjy5GL6IczrHH4aqNj4=;
        b=YFUHvof4qutg11O2ayYJ5UApkysVAsiL2ZzzUK7lPknxJXEUQ8q2AnJv9fy3+EFscR
         KOFUrbMRKcO7fVGWkRten3F1ke2II3C2IwzsnGwKtaVsymQ3b+OLfJJYT/DPdFuh6XBK
         Z2YKSh0ygZ8olSpwxB0eyFvYlR4zEQKwdajEzDwVNh5GRbg8nQeT4U4A75+Wj7NiRKhb
         JVqPls1jfsVm+lgJ/Lrvd/27eK/E67vhbOF+XdBEpevG0T2TUJ6E3mymWIYZtAzGhszs
         glz+TDJdrd/+F5QfNFx89tTfiVQW5pm3FIwi8V5NxSwQ4VT2yniANnEZgdxhQoP6JHgE
         AaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486518; x=1717091318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4r6TCjebwmoal19hsNaIlox9kjy5GL6IczrHH4aqNj4=;
        b=lMtRhubwOv6Friu9yHy0ti500klwHXzYzGNNws6q1B1a1TmK+6US5Y75IYkJzMPLaA
         /ANbRUJzl5YfVeKJPdOU9OsI//vjMtojoNV93Cy4t8EjUhXMQp59i2PAKkWH2UCvGL2t
         IDHXsucvWr77ZCwR4+ZcHQGHUdAIWp6/Sv3YmxbvQ0I9ua4xjjUqCNBXRzPyZvjWkJr8
         DtxMlxZbT+u1f0/jpj0fdyCEp+U6asxHoSvM19Sb1xmrDsEOL9LYM/N3dTca9apnB2AO
         hwxTKkDey6sC0VsUvKMEl1y8PsL4SCVw1gpAeCt0yuha/bgkX3OWj7WwqUKsffy+J6Va
         KF6A==
X-Forwarded-Encrypted: i=1; AJvYcCWXfkLi1jAO2UNaaNfkLRLaEMZM978nto+QzafEVMF+RBVbHSuGsGR+9+MwP+U60ISmAGtczk3ZEV05vW0YIoceqZLGUYC1U2JZ
X-Gm-Message-State: AOJu0YxOKTXeB1OvqANA7CR0Da1G9Sm2PI+QQlqugOn7LEtD17L1zN7W
	nuZllWubphyZpPxgBv64+MwGJgh3Cgyf9peOI/h9Y7T5TEdOuLACpVTsrA==
X-Google-Smtp-Source: AGHT+IHWVrXQSnx82ntFoZX/SGrXTrSTjtR9HqgzEtaI+q3GNixRc445TQcUUiX1AHlXQqhKfb070g==
X-Received: by 2002:a17:903:244b:b0:1e4:436e:801b with SMTP id d9443c01a7336-1f4498f404bmr295475ad.67.1716486517545;
        Thu, 23 May 2024 10:48:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:48:37 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	gregory.price@memverge.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com,
	wj28.lee@gmail.com,
	armbru@redhat.com,
	mst@redhat.com
Subject: [PATCH v8 00/14] Enabling DCD emulation support in Qemu
Date: Thu, 23 May 2024 10:44:40 -0700
Message-ID: <20240523174651.1089554-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <nifan.cxl@gmail.com>

A git tree of this series can be found here (with one extra commit on top
for printing out accepted/pending extent list for testing): 
https://github.com/moking/qemu/tree/dcd-v8-qapi

v7->v8:

This version carries over the following two patches from Gregory.
1. hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference
https://gitlab.com/jic23/qemu/-/commit/f44ebc5a455ccdd6535879b0c5824e0d76b04da5
2. hw/cxl/mailbox: interface to add CCI commands to an existing CCI
https://gitlab.com/jic23/qemu/-/commit/00a4dd8b388add03c588298f665ee918626296a5

Note, the above two patches are not directly related to DCD emulation.

All the following patches in this series are built on top of mainstream QEMU
and the above two patches.

The most significant changes of v8 is in Patch 11 (Patch 9 in v7). Based on
feedback from Markus and Jonathan, the QMP interfaces for adding and releasing
DC extents have been redesigned and now they look like below,

# add a 128MB extent at offset 0 to region 0
	{ "execute": "cxl-add-dynamic-capacity",
	  "arguments": {
		  "path": "/machine/peripheral/cxl-memdev0",
          "host-id":0,
          "selection-policy": 'prescriptive',
		  "region": 0,
          "tag": "",
		  "extents": [
		  {
			  "offset": 0,
			  "len": 134217728
		  }
		  ]
	  }
	}

Note: tag is optional.

# Release a 128MB extent at offset 0 from region 0
 { "execute": "cxl-release-dynamic-capacity",
	  "arguments": {
		  "path": "/machine/peripheral/cxl-memdev0",
          "host-id":0,
          "removal-policy":"prescriptive",
          "forced-removal": false,
          "sanitize-on-release": false,
          "region": 0,
          "tag": "",
		  "extents": [
		  {
			  "offset": 0,
			  "len": 134217728
		  }
		  ]
	  }
	}
    
Note: removal-policy, sanitize-on-release and tag are optional.
    
Other changes include,
1. Applied tags to patches. 
2. Replaced error_setq with error_append_hint for cxl_create_dc_region error
   case in Patch 6 (Patch 4 in v7); (Zhijian Li)
3. Updated the error message to include region size information in
    cxl_create_dc_region.
4. set range1_size_hi to 0 for DCD in build_dvsec. (Jonathan)
5. Several minor format fixes.

Thanks Markus, Jonathan, Gregory, and Zhijian for reviewing v7 and
svetly Todorov for testing v7.

This series pass the same tests as v7 check the cover letter of v7 for
more details. Additionally, we tested the QAPI interface for
adding/releasing DC extents with optional input parameters.
  

v7: https://lore.kernel.org/linux-cxl/5856b7a4-4082-465f-9f61-b1ec6c35ef0f@fujitsu.com/T/#mec4c85022ce28c80b241aaf2d5431cadaa45f097


Fan Ni (12):
  hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
    payload of identify memory device command
  hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
    and mailbox command support
  include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
    type3 memory devices
  hw/mem/cxl_type3: Add support to create DC regions to type3 memory
    devices
  hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
    size instead of mr as argument
  hw/mem/cxl_type3: Add host backend and address space handling for DC
    regions
  hw/mem/cxl_type3: Add DC extent list representative and get DC extent
    list mailbox support
  hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
    dynamic capacity response
  hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
    extents
  hw/mem/cxl_type3: Add DPA range validation for accesses to DC regions
  hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
  hw/mem/cxl_type3: Allow to release extent superset in QMP interface

Gregory Price (2):
  hw/cxl/mailbox: change CCI cmd set structure to be a member, not a
    reference
  hw/cxl/mailbox: interface to add CCI commands to an existing CCI

 hw/cxl/cxl-mailbox-utils.c  | 658 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 634 ++++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3_stubs.c    |  25 ++
 include/hw/cxl/cxl_device.h |  85 ++++-
 include/hw/cxl/cxl_events.h |  18 +
 qapi/cxl.json               | 143 ++++++++
 6 files changed, 1511 insertions(+), 52 deletions(-)

-- 
2.43.0

