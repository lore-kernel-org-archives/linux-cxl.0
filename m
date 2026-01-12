Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A2C365A0E
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235755; cv=none; b=mN1rYJWiQGBqBRZ4NdQC26qgSVNb5Aylqjj4iNKW72XdDQ5FnNfOsxUjYJaUEKpF12ovZsp7g6iYcZtkq42EejWRU+ZxRUhoyaKcxQWQgaBHQhzI48ZtUhCxmQDYD5mJ98bQ8o3PAZ5KDanuRj0VECTZt3w3bRwHHGPXGYhORZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235755; c=relaxed/simple;
	bh=gpsOr3755Ux5xmdukoW2X8qMnx7XteFxZvnDCBJsX4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tDWUR2ou39uLWLlhX6z83zXBrpJEXR298VqPCcCMwcP/3mi+pUyHvykX7dNoLSQbGmFEkg72i/gNUf40KylA8hssL0QVbvUFGRpdbQ+RIfEPgLeFYZ8a6TWyUGlgtgql96roA2C1ZGLoL7z7ah3F9GESGjqzwMhYu3oVJDB3Wjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ufeXKjLx; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ufeXKjLx"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b144ec3aa8so697301885a.2
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 08:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768235751; x=1768840551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ePycxZJ1mgqTuyoBlUwMyocel7iPIQTnJUQK6itGIaQ=;
        b=ufeXKjLx5Rq9UwYCnvclEjZ3eDccv/gm5+HzToF2dMOdF+eA0orEj/789T1xF0hwCn
         WKpoprb8I1cQ5uCAIFnxleNsvSfidPNnRTs5M0SM9WgntoakZhOuyONWvRoFX5IvYY/r
         gMFYM0LJh2VMGEsHxI1UuLMJlm94iM+LAu3QCmvqsnAq8GWysQLrOhDLnYVLKlMk/qvg
         WqD9jTPmPj+25KBRwJuTDWXTGvVejTYiOvXsiM6Oh7AD+pkKdVbdHkEns+afyen892Vm
         aqRKOn3twC8rpvwT9tNZIum2GhNGZDJk3qJIgjmHivZZ9ulgJyBsOdaMl8SfTCTacygq
         osMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768235751; x=1768840551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePycxZJ1mgqTuyoBlUwMyocel7iPIQTnJUQK6itGIaQ=;
        b=qfMZ1UH18yBvSpLv0mSG4fbi1HfxwyPqVERZ959KRsbmJFkQhCbA3U9iCJEQqpjiJP
         KYlVZ8s6WHGh45FDXXjKzwGjH++2N8CiomMU+cyYj/UIundG2vwPgnOcDhVEORsJDENe
         XqS3pdkWbN/KGKnUgJk9K4ENR9hlW4WRDUdkxQc3fBXt5/q/4RdaggoDZiqgGJI3Zcuu
         Roy1gcIARJKF+fzxgugNLguKyWZlQDJAGILyip8lKyDqwy1O7I+/Cj0hdKoMGTq1c3hZ
         fYZFGIN/E8Tl+LYG1p9gSsVNy3JrBV6uTldpOD3ZMjONHbnB1V/xNKp2RrIDQcDbjTyc
         QFUA==
X-Gm-Message-State: AOJu0YydRadNkrUQGooXVsE9f0VOg9ImRdWhnvoROOt4jiXHeMXeKRqB
	xHNfPjRTLkJ2KNRzK9OEj7nQe6EETzPCdXwPR0vlOCwQrXL4wbdR6YvbSrVVGYyzDy6ATP1IR1n
	c5BOH
X-Gm-Gg: AY/fxX5p3v3e4PYu5kz4sI1Q2w8lr3oeLJ+hKIPBJoTO2wfJ4ieNreki9UixeON155E
	qzUQO8kQUZzN4mtjG5BuAB9WOsihZDUNQq5id1BcIh6PFITsiCmcbjem5uMx0anE1GCp8cKRChq
	hmUi4//LuLCrad1VpWClnpC5bDYlVp7IrlvnAYgPGWUBIlnkN9s+5foY0Al03cjnC+nMAWWtDW7
	bp5yBI0uAjn+BhPzn/yNnnNqbKgpw7pRtRXqnGULxbuMvW1mLz/DxTwR25KQXATLIu4x4RohuEP
	QkVbCNC6bHGRvSd2As09tMThFlsbb9YLkVmOSA1Hh+VyugH9YVLpPcyepVKf+j96ISsvOkpczPg
	UpNGitmYsEwz6NWV7NYHjarediaHJtIlMImOv2GC6S14lGqkUwdH1UI9IfPDZqvkbYMoVwDJEux
	0GOCRfWOx8Y0eIcrLnkPpFtHKFiWmwg1CNkAMZhjIMx55FY8QGIBs3radt2T6c429XNQsSYRsCM
	xQ=
X-Google-Smtp-Source: AGHT+IFxIe3ihpaJHVbSiqOWJqGbHb0BDWNXz9XWAYoK7mF5nXSgfqV4kcpOVAdZ/TF7pemwnmWKHw==
X-Received: by 2002:a05:620a:4051:b0:8b2:eb66:c5d with SMTP id af79cd13be357-8c3893a5989mr2522088085a.39.1768235750902;
        Mon, 12 Jan 2026 08:35:50 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a7962sm1489152685a.11.2026.01.12.08.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:35:50 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH 0/6] CXL: Introduce memory controller abstraction and sysram controller
Date: Mon, 12 Jan 2026 11:35:08 -0500
Message-ID: <20260112163514.2551809-1-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL driver currently hands policy management over to the DAX
subsystem for sysram regions.  This makes building policy around
entire regions clunky and at times difficult - for example, requiring
multiple actions to reliably offline and hot-unplug memory.

This series introduces a memory controller abstraction for CXL regions
and adds a "sysram" controller that directly hotplugs memory without
needing to route through DAX.  This simplifies the sysram use case
considerably.

This also prepares for future use cases which may require different
memory controller logic (such as private numa nodes).

We organize the controllers into core/memctrl/*_region.c files.

The series is organized as follows:

Patch 1 introduces the cxl_memctrl_mode enum and region->memctrl field,
allowing regions to be switched between different memory controllers.
The supported modes are NONE, AUTO, and DAX initially.  Auto-created
regions default to AUTO, while manually created regions default to NONE
(requiring explicit controller selection).

Patch 2 adds the sysram_region memory controller, which provides direct
memory hotplug without DAX intermediation.  New sysfs controls are
exposed under region/memctrl/:
  - hotplug:   trigger memory hotplug
  - hotunplug: offline and hotunplug memory
  - state:     online/online_normal/offline

Patch 3 refactors existing pmem memctrl logic out of region.c into the
new memctrl/pmem_region.c, simplifying controller selection in region
probe.

Patch 4 adds CONFIG_CXL_REGION_CTRL_AUTO_* options, allowing users to
configure auto-regions to default to SYSRAM instead of DAX for existing
simple system configurations (i.e. local memory expansion only).

Patch 5 adds CONFIG_CXL_REGION_SYSRAM_DEFAULT_* options to control the
default state of sysram blocks (OFFLINE, ONLINE/ZONE_MOVABLE, or
ONLINE_NORMAL/ZONE_NORMAL).  This provides an alternative to the global
MHP auto-online setting which may cause issues with other devices.

Online defaults to ZONE_MOVABLE to defend hot-unplug by default.
This is the opposite of memory blocks "online" and "online_movable".

Patch 6 adds a memory_notify callback that prevents memory blocks from
being onlined into ZONE_NORMAL when the controller state is set to
ZONE_MOVABLE.  This protects against administrators accidentally
breaking hot-unpluggability by writing "offline" then "online" to the
memory block sysfs.

Gregory Price (6):
  drivers/cxl: add cxl_memctrl_mode and region->memctrl
  cxl: add sysram_region memory controller
  cxl/core/region: move pmem memctrl logic into memctrl/pmem_region
  cxl: add CONFIG_CXL_REGION_CTRL_AUTO_* build config options
  cxl: add CXL_REGION_SYSRAM_DEFAULT_* build options
  cxl/sysram: disallow onlining in ZONE_NORMAL if state is movable only

 drivers/cxl/Kconfig                      |  72 ++++
 drivers/cxl/core/Makefile                |   1 +
 drivers/cxl/core/core.h                  |   5 +
 drivers/cxl/core/memctrl/Makefile        |   6 +
 drivers/cxl/core/memctrl/dax_region.c    |  79 ++++
 drivers/cxl/core/memctrl/memctrl.c       |  48 +++
 drivers/cxl/core/memctrl/pmem_region.c   | 191 +++++++++
 drivers/cxl/core/memctrl/sysram_region.c | 520 +++++++++++++++++++++++
 drivers/cxl/core/region.c                | 358 ++++------------
 drivers/cxl/cxl.h                        |  18 +
 10 files changed, 1013 insertions(+), 285 deletions(-)
 create mode 100644 drivers/cxl/core/memctrl/Makefile
 create mode 100644 drivers/cxl/core/memctrl/dax_region.c
 create mode 100644 drivers/cxl/core/memctrl/memctrl.c
 create mode 100644 drivers/cxl/core/memctrl/pmem_region.c
 create mode 100644 drivers/cxl/core/memctrl/sysram_region.c

-- 
2.52.0

