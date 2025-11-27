Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7420723E325
	for <linux-cxl@vger.kernel.org>; Thu, 27 Nov 2025 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764284137; cv=none; b=hDNSYF6G3iGXUDsJ4VCVAQUltWdRxkUIuuZfY/5h8bJLkdrAoiNK9r8IIPgZzamJHPK+pLsrx8f0WMhlJmk5g0o6x2pNeHhNyjWTrnXwXSD9Ue8W4rbJmJJ9PULOLsHh0LZ4+98T4pX3ZQP/BnmH0N5Am7J/VlexKORPeMHPQEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764284137; c=relaxed/simple;
	bh=BKRJ2pHPMIMV+CC5hDB92p/8RnI6PxqsOhaPmrWiOi4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q4d0KCLBoDHTr6Z8zAkp4JsM2ckQzdlbAgW/X/4hNQhVPXjuVu+p3rtPpTiKpxntAgL/h8qJK75OGk9vA6DHLrdDteDT3ByPRbAc55rOUVEyttSrZSmssPAsrXN5JlDblaWTvyULenTNlMm5GBbkAOMHsALqx1mnDoN4NV69qhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dHWw22Nz6zHnGcV;
	Fri, 28 Nov 2025 06:54:42 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id A6FA51402E9;
	Fri, 28 Nov 2025 06:55:31 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.72.83) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 22:55:30 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <qemu-devel@nongnu.org>
CC: <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>, <eblake@redhat.com>,
	<armbru@redhat.com>, <berrange@redhat.com>, <pbonzini@redhat.com>,
	<mst@redhat.com>, <lizhijian@fujitsu.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: [RFC QEMU PATCH 0/7] Application Specific Tagged Memory Support in CXL Type 3 Devices
Date: Thu, 27 Nov 2025 22:55:18 +0000
Message-ID: <20251127225526.700-1-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

Application may need memory for specific purposes. For example, a
database application may want to allocate memory that is optimized for
workloads involving large datasets and frequent read/write operations.
Or there might be a large read only dataset that can be mapped to a CXL
Type 3 device.

There must be a way to feed this memory into the VMs. This series
introduces a tagged memory backend object that allows tagging memory
regions with application specific tags. The tagged memory regions can
then be used as backing memory for CXL Type 3 devices.

This series includes the following changes:
 - A new tagged memory backend object is introduced that allows
   allocating and managing memory regions with specific tags.
 - The CXL Type 3 device implementation is modified to support using
   tagged memory regions as backing memory.
 - New QAPI commands and structures are added to facilitate the
   management of tagged memory regions and their association with CXL
   Type 3 devices.
 - The CXL extent management code is updated to handle tagged memory
   regions appropriately, including lazy loading and direct mapping
   optimizations.

# Assumptions:

1) Each extent must be mapped entirely to a single tagged memory
backend.
2) Punching holes in extents is not supported, and not allowed.

# Diagram that illustrates the design:

                  VM
                  |
                  | FMW.0
                  v
                +--------------------+
                |   CXL Type-3 dev   |
                |  +--------------+  |
                |  | extent0 T0   |----> backend0 (tag T0)
                |  | extent1 T1   |----> backend1 (tag T1)
                |  | extent2 T2   |----> backend2 (tag T2)
                |  +--------------+  |
                +--------------------+


# Tested scenario:

Created two different tagged memory backends with different tags at
runtime with QMP commands, and then added two different extents that
cover the whole memory backends specified by tags.

# Changes to the kernel:

UUID/tags must be allowed in the DCD patchset available online from
Ira which is series depends on [1].

# Commands used:

# First memory backend with tag 5be13bce-ae34-4a77-b6c3-16df975fcf1a:

{
    "execute": "object-add",
    "arguments": {
        "qom-type": "memory-backend-tagged",
        "id": "tm0",
        "size": 1073741824,
        "tag": "5be13bce-ae34-4a77-b6c3-16df975fcf1a"
    }
}

## Second memory backend with tag 6be13bce-ae34-4a77-b6c3-16df975fcf1a:

{

    "execute": "object-add",
    "arguments": {
        "qom-type": "memory-backend-tagged",
        "id": "tm1",
        "size": 1073741824,
        "tag": "6be13bce-ae34-4a77-b6c3-16df975fcf1a"
    }
}

## Add capacity extent with tag 5be13bce-ae34-4a77-b6c3-16df975fcf1a:

{
    "execute": "cxl-add-dynamic-capacity",
	"arguments": {
		"path": "/machine/peripheral/cxl-vmem0",
		"host-id": 0,
		"selection-policy": "prescriptive",
		"region": 0,
		"tag": "5be13bce-ae34-4a77-b6c3-16df975fcf1a",
		"extents": [
			{
				"offset": 0,
				"len": 1073741824
			}
		]
	}
}

## Add capacity extent with tag 6be13bce-ae34-4a77-b6c3-16df975fcf1a:

{
    "execute": "cxl-add-dynamic-capacity",
    "arguments": {
        "path": "/machine/peripheral/cxl-vmem0",
        "host-id": 0,
        "selection-policy": "prescriptive",
        "region": 0,
        "tag": "6be13bce-ae34-4a77-b6c3-16df975fcf1a",
        "extents": [
            {
                "offset": 1073741824,
                "len": 1073741824
            }
        ]
    }
}

## Release capacity extent with tag 5be13bce-ae34-4a77-b6c3-16df975fcf1a:

{ "execute": "cxl-release-dynamic-capacity",
	"arguments": {
		"path": "/machine/peripheral/cxl-vmem0",
		"host-id": 0,
		"removal-policy":"tag-based",
        	"tag": "5be13bce-ae34-4a77-b6c3-16df975fcf1a",
		"region": 0,
		"extents": [
		{
			"offset": 0,
			"len": 1073741824
		}
		]
	}
}

## Release capacity extent with tag 6be13bce-ae34-4a77-b6c3-16df975fcf1a:

{ "execute": "cxl-release-dynamic-capacity",
	"arguments": {
		"path": "/machine/peripheral/cxl-vmem0",
		"host-id": 0,
		"removal-policy":"tag-based",
        	"tag": "6be13bce-ae34-4a77-b6c3-16df975fcf1a",
		"region": 0,
		"extents": [
		{
			"offset": 1073741824,
			"len": 1073741824
		}
		]
	}
}

## Checking if capacity extents are removed successfully:

{
  "execute": "cxl-release-dynamic-capacity-status",
  "arguments": {
	"path": "/machine/peripheral/cxl-vmem0",
	"host-id": 0,
        "tag": "6be13bce-ae34-4a77-b6c3-16df975fcf1a",
	"region": 0
  }
}

Response:
{
    "return": {
        "status": "not-found"
    }
}

# QEMU Command:

$ qemu-system-x86_64 \
  -cpu max \
  -smp 8 \
  -drive file=debian12.qcow2,format=qcow2,if=none,id=mydrive0,index=0 \
  -device virtio-blk-pci,drive=mydrive0 \
  -kernel bzImage \
  -append "console=ttyS0,115200 TERM=linux root=/dev/vda1 nokaslr ignore_loglevel \
           fsck.mode=skip cxl_acpi.dyndbg=+fplm cxl_pci.dyndbg=+fplm cxl" \
  -nographic \
  -serial mon:stdio \
  -machine type=q35,accel=tcg \
  -virtfs local,path=hostshare/,mount_tag=hostshare,security_model=passthrough,id=hostshare \
  -qmp tcp:localhost:4444,server,wait=off \
  -netdev user,id=network0,hostfwd=tcp::2025-:22 \
  -device virtio-net,netdev=network0 \
  -m 12G,maxmem=20G,slots=10 \
  -object memory-backend-ram,id=vmem0,share=on,size=2G \
  -device pxb-cxl,numa_node=0,bus_nr=23,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
  -M cxl=on,cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=6G \
  -device cxl-type3,bus=root_port13,id=cxl-vmem0,num-dc-regions=1,dc-regions-total-size=4G

BASE: 2a3af116a78e1adceb24521d76199b97f08c0f1d

Depends-on:
https://lore.kernel.org/linux-cxl/20251013160151.000039dd.alireza.sanaee@huawei.com/

Depends-on:
https://lore.kernel.org/all/20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com/

[1] https://github.com/sarsanaee/linux/tree/allow_uuid_ira

Alireza Sanaee (7):
  hw/mem: Add tagged memory backend object
  hw/cxl: Allow initializing type3 device with no backing device
  hw/cxl: Change Extent add/remove APIs for lazy memory backend.
  hw/cxl: Map lazy memory backend after host acceptance
  hw/cxl: Add performant direct mapping for extents
  hw/cxl: Add remove alias functionality for extent direct mapping
  hw/cxl: Add tag-based removal functionality

 hw/cxl/cxl-host.c           |   6 +
 hw/cxl/cxl-mailbox-utils.c  | 190 +++++++++++++++++++--
 hw/mem/cxl_type3.c          | 326 ++++++++++++++++++++++++++++++------
 hw/mem/meson.build          |   1 +
 hw/mem/tagged_mem.c         | 116 +++++++++++++
 include/hw/cxl/cxl_device.h |  44 ++++-
 include/hw/mem/tagged_mem.h |  31 ++++
 qapi/cxl.json               |  46 +++++
 qapi/qom.json               |  15 ++
 9 files changed, 707 insertions(+), 68 deletions(-)
 create mode 100644 hw/mem/tagged_mem.c
 create mode 100644 include/hw/mem/tagged_mem.h

-- 
2.43.0

