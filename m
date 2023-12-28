Received: from mail-m12746.qiye.163.com (mail-m12746.qiye.163.com [115.236.127.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC36FA1
	for <linux-cxl@vger.kernel.org>; Thu, 28 Dec 2023 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easystack.cn
Received: from ubuntu-22-04.. (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id F3B4E860259;
	Thu, 28 Dec 2023 14:05:14 +0800 (CST)
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	ave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [RFC PATCH 0/4] cxl: introduce CXL Virtualization module
Date: Thu, 28 Dec 2023 06:05:06 +0000
Message-Id: <20231228060510.1178981-1-dongsheng.yang@easystack.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTxgdVh4eGBpLQk4fH00aGlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8caf06eb05023ckunmf3b4e860259
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTI6Mjo*STcwFyJDFgkSKysK
	ODRPCjdVSlVKTEtITE9ITkpOQktPVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBTkxDQzcG

Hi all:
	This patchset introduce cxlv module to allow user to
create virtual cxl device. it's based linux6.7-rc5, you can
get the code from https://github.com/DataTravelGuide/linux

	As the real CXL device is not widely available now, we need
some virtual cxl device to do uplayer software developing or
testing. Qemu is good for functional testing, but not good
for some performance testing.

	The new CXLV module allow user to use the reserved RAM[1], to
create virtual cxl device. When the cxlv module load, it will
create a directory named as "cxl_virt" under /sys/devices/virtual:

	"/sys/devices/virtual/cxl_virt/"

that's the top level device for all cxlv devices.
At the same time, cxlv module will create a debugfs directory:

/sys/kernel/debug/cxl/cxlv
├── create
└── remove

the create and remove debugfs file is the cxlv entry to create or remove
a cxlv device.

	Each cxlv device have its owned virtual pci related bridge and bus, cxlv
will create a new root_port for the new cxlv device, setup cxl ports for
dport and nvdimm-bridge. After that, we will add the virtual pci device,
that will go into the cxl_pci_probe to setup new memdev.

	Then we can see the cxl device with cxl list and use it as a real cxl
device.

 $ echo "memstart=$((8*1024*1024*1024)),cxltype=3,pmem=1,memsize=$((2*1024*1024*1024))" > /sys/kernel/debug/cxl/cxlv/create
 $ cxl list
[
  {
    "memdev":"mem0",
    "pmem_size":1879048192,
    "serial":0,
    "numa_node":0,
    "host":"0010:01:00.0"
  }
]
 $ cxl create-region -m mem0 -d decoder0.0 -t pmem
{
  "region":"region0",
  "resource":"0x210000000",
  "size":"1792.00 MiB (1879.05 MB)",
  "type":"pmem",
  "interleave_ways":1,
  "interleave_granularity":256,
  "decode_state":"commit",
  "mappings":[
    {
      "position":0,
      "memdev":"mem0",
      "decoder":"decoder2.0"
    }
  ]
}
cxl region: cmd_create_region: created 1 region

 $ ndctl create-namespace -r region0 -m fsdax --map dev -t pmem -b 0
{
  "dev":"namespace0.0",
  "mode":"fsdax",
  "map":"dev",
  "size":"1762.00 MiB (1847.59 MB)",
  "uuid":"686fd289-a252-42cf-a3a5-95a39ed5c9d5",
  "sector_size":512,
  "align":2097152,
  "blockdev":"pmem0"
}

 $ mkfs.xfs -f /dev/pmem0 
meta-data=/dev/pmem0             isize=512    agcount=4, agsize=112768
blks
         =                       sectsz=4096  attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1,
rmapbt=0
         =                       reflink=1    bigtime=0 inobtcount=0
data     =                       bsize=4096   blocks=451072, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0

Any comment is welcome!

TODO: implement cxlv command in ndctl to do cxlv device management.

[1]: Add argument in kernel command line: "memmap=nn[KMG]$ss[KMG]",
detail in Documentation/driver-api/cxl/memory-devices.rst

Thanx

Dongsheng Yang (4):
  cxl: move some function from acpi module to core module
  cxl/port: allow dport host to be driver-less device
  cxl/port: introduce cxl_disable_port() function
  cxl: introduce CXL Virtualization module

 MAINTAINERS                         |   6 +
 drivers/cxl/Kconfig                 |  11 +
 drivers/cxl/Makefile                |   1 +
 drivers/cxl/acpi.c                  | 143 +-----
 drivers/cxl/core/port.c             | 231 ++++++++-
 drivers/cxl/cxl.h                   |   6 +
 drivers/cxl/cxl_virt/Makefile       |   5 +
 drivers/cxl/cxl_virt/cxlv.h         |  87 ++++
 drivers/cxl/cxl_virt/cxlv_debugfs.c | 260 ++++++++++
 drivers/cxl/cxl_virt/cxlv_device.c  | 311 ++++++++++++
 drivers/cxl/cxl_virt/cxlv_main.c    |  67 +++
 drivers/cxl/cxl_virt/cxlv_pci.c     | 710 ++++++++++++++++++++++++++++
 drivers/cxl/cxl_virt/cxlv_pci.h     | 549 +++++++++++++++++++++
 drivers/cxl/cxl_virt/cxlv_port.c    | 149 ++++++
 14 files changed, 2388 insertions(+), 148 deletions(-)
 create mode 100644 drivers/cxl/cxl_virt/Makefile
 create mode 100644 drivers/cxl/cxl_virt/cxlv.h
 create mode 100644 drivers/cxl/cxl_virt/cxlv_debugfs.c
 create mode 100644 drivers/cxl/cxl_virt/cxlv_device.c
 create mode 100644 drivers/cxl/cxl_virt/cxlv_main.c
 create mode 100644 drivers/cxl/cxl_virt/cxlv_pci.c
 create mode 100644 drivers/cxl/cxl_virt/cxlv_pci.h
 create mode 100644 drivers/cxl/cxl_virt/cxlv_port.c

-- 
2.34.1

