Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=139.138.37.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008446;
	b=mRI5BEr9vRddi/HjEBEuK1ObNCRyW4kMiFxHLTOYIpJFcdzXBbQm/KGY59dNd8HnQHQy
	 ppOUnVS0YJ8lZTCka5rAd4oGMJdc74Uvq0cyTUn7k5DL3Te7XUbvCTXMN9a5gf7eG6qmJ
	 T4jJ2LdEu7JpElpaDHWfVc1Fqvp5OmEyQuO6sFZOAl58pGJuiP+80ykBtqysl9tVGow+C
	 fhdO5uZkpPE7ljF8C90tsvzC8a56p/BZoSvNe5B0AHlMRw85NhocbGUX+orcCkyPRmf14
	 6RMSbzxNHIORiP/LASQJXuaoe9lVlH/D/N2dvQOwDJkiWMcv8VPbjDrKlbYCzmrQFaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008446;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BWxLp7laZc774WkxErgGQ6h9WGpFegWQayFabiLjk8g=;
	b=dSVBww8W8+lZ92Js2PW35zWVso1QZqRCnWtvFbYtdEIPOL7BP+je/Cewhm2qnm9lkIlO
	 duiGDcsycHAceI0PQG53Sw5B3ishTCainu0ZyPggWaPRuuufFbXiImp0nK2DOXXo8KG9J
	 53QN1rEOaUerSsdpSbV15nWZt9o5x0Amxl9m7e+0oyyu/7qlDnmi50T3B2ThDV7yoAjZ4
	 VpHXn0QPrXJB8eBLij2HGM3vrIxOPGskLS/xp4Ou2SuvohLmxpur36txQCISjQpbx/0bm
	 /YdvWmCBedBY8pOAMkC/T7bWo6YE0ZLfCHt8w8OLy+3PzFY3pmK1C3i1T/Gi2o3jm6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=SGQrr3mX;
	arc=none smtp.remote-ip=139.138.37.100
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8011606A31B
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8011606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=SGQrr3mX
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1793008445; x=1824544445;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w6UU+vIiuqZc0J6GyS2zK2hsjo3ELADEVjFwNOBX6P8=;
  b=SGQrr3mXnUHH5H/Z1n4QhKJ7aXrCpkKlTlCWmX9PWZ7xFiqrHKzD+Ryp
   L+/t+108j6AatksE12w3uWc7MiEMb8a/tXuH3HCjVDbbogkm4gWW7ILMC
   a6VZBiMauzRtVp+oS33yauklDrQ5AOZXE6r5+Iz3mUPyAK/yiowVswU5I
   ENcEAdUHJMXP6/J1UezhDSJ9y/toLEGJ+mDiQmHG7Zo0bQszyjD7iRGBc
   tccAt1h7MvNpy7qD91WAdV0WYQ3u4psXF5n7915bgMSw9cA82PHln0OlL
   ey1SwU9BssAVbMZKIqoqlMKQlIhS4Bb1LWv9RHdrIqW79IjnY8/pxaI1W
   Q==;
X-CSE-ConnectionGUID: 1vhMdTpmSy+T9dt1AmdeWw==
X-CSE-MsgGUID: l6blnSkCSNeNOmqfFaCD8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="237204725"
X-IronPort-AV: E=Sophos;i="6.27,179,1786978800"; 
   d="scan'208";a="237204725"
Received: from gmgwnl01.global.fujitsu.com (HELO mgmgwnl01.global.fujitsu.com) ([52.143.17.124])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 18:54:04 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mgmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 0239633FB
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:04 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (unknown [10.128.233.114])
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTP id 716961800D72
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:03 +0000 (UTC)
Received: from tanjiro.soft.fujitsu.com (unknown [10.118.236.61])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 0931B2069EA7;
	Mon, 26 Oct 2026 18:54:02 +0900 (JST)
From: Yukiya Takaki <fj2110jc@fujitsu.com>
To: qemu-devel@nongnu.org
Cc: Yukiya Takaki <fj2110jc@fujitsu.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Anisa Su <anisa.su@samsung.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	linux-cxl@vger.kernel.org,
	qemu-arm@nongnu.org,
	"Wolski, Tomasz" <tomasz.wolski@fujitsu.com>,
	lizhijian@fujitsu.com,
	y-goto@fujitsu.com,
	yukiya.takaki@gmail.com
Subject: [PATCH RFC 0/7] QEMU/hw/cxl: Allow CXL Type 3 memory regions to be initialized at guest boot
Date: Mon, 26 Oct 2026 19:03:21 +0900
Message-ID: <cover.1793003983.git.fj2110jc@fujitsu.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

I’m a student intern, and this is my first time sending patches to an open source mailing list.

This patch series configures QEMU’s CXL Type 3 devices so that guest operating systems can automatically discover
and create CXL regions during boot, aligning QEMU’s behavior with real hardware.

Background and motivation
  Currently, during guest boot QEMU does not provide the information or register programming needed for the guest OS
  to initialize CXL Type 3 memory, so using it still requires an explicit action in the guest (for example, running the cxl create-region command).
  By contrast, on some physical systems the firmware automatically allocates CXL memory ranges and exposes them to the OS,
   allowing the Linux CXL driver to discover and create regions during boot.
  This patch series is a first, experimental attempt to reproduce that behavior in QEMU.

  Some parts of this implementation are based on Li, Zhijian’s work in:
  https://github.com/zhijianli88/qemu/tree/program-decoder-v2

  I would like to ask for feedback on whether this approach makes sense and whether I should continue to enhance it.

Approach
  This patch first adds a program_hdm_decoder option to cxl-type3.
  When program-hdm-decoder is enabled on cxl-type3, QEMU will:
    1) program endpoint/host-bridge HDM decoder state,
    2) expose Type 3 ranges as E820_SOFT_RESERVED on x86,
    3) create memory-only NUMA nodes for those ranges,
    4) emit SRAT memory-affinity entries mapping each Type 3 HPA range to its node ID

  On real hardware, HDM decoder programming and memory layout are typically handled by firmware, so they would ideally be managed by SeaBIOS.
  However, in the current QEMU/SeaBIOS model, E820 and SRAT are built on the QEMU side, and pushing HDM decoder programming
  into SeaBIOS would introduce additional complexity and risk inconsistencies.

Testing
  We ran tests in the following environment and confirmed that CXL regions were created at boot, NUMA nodes were set up,
  and E820_SOFT_RESERVED entries appeared in the E820 table:

  - BIOS: SeaBIOS c2a33ad9ad1452e23b41c4ac44a3bc6be8ebc4cf
  - CXL memory: 4 GB
  - CFMWS: 4 GB
  - Host bridge: 1

  The following is the startup script.

  sudo /path/to/qemu/build/qemu-system-x86_64 \
    -name guest=cxl \
    -nographic \
    -machine q35,accel=tcg,nvdimm=on,cxl=on \
    -cpu max -smp 4,sockets=4,cores=1,threads=1 \
    -m size=4G,slots=10,maxmem=20G \
    -drive file=/path/to/image.qcow2,format=qcow2,index=0,media=disk,id=hd \
    -bios /path/to/seabios/out/bios.bin \
    -nic bridge,br=virbr0,model=e1000e,mac=52:54:00:b5:4e:7c \
    -object memory-backend-ram,size=2G,id=m0 \
    -object memory-backend-ram,size=2G,id=m1 \
    -numa node,nodeid=0,cpus=0-1,memdev=m0 \
    -numa node,nodeid=1,cpus=2-3,memdev=m1 \
    -device pcie-root-port,id=pci-root,slot=4,bus=pcie.0,chassis=0 \
    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
    -device cxl-rp,port=0,id=root_port13,bus=cxl.1,chassis=0,slot=2 \
    -object memory-backend-ram,size=4G,share=on,id=vmem0 \
    -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,program-hdm-decoder=true \
    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
  
  Furthermore, we conducted the experiment in which we added two CXL Type3.

  - CXL memory: 4 GB × 2
  - CFMWS: 4 GB × 2

  The following is the startup script.
    
  sudo /path/to/qemu/build/qemu-system-x86_64 \
    -name guest=cxl \
    -nographic \
    -machine q35,accel=tcg,nvdimm=on,cxl=on,hmat=on \
    -cpu max -smp 4,sockets=4,cores=1,threads=1 \
    -m size=4G,slots=10,maxmem=20G \
    -drive file=/path/to/image.qcow2,format=qcow2,index=0,media=disk,id=hd \
    -bios /path/to/seabios/out/bios.bin \
    -nic bridge,br=virbr0,model=e1000e,mac=52:54:00:b5:4e:7c \
    -object memory-backend-ram,size=2G,id=m0 \
    -object memory-backend-ram,size=2G,id=m1 \
    -numa node,nodeid=0,cpus=0-1,memdev=m0 \
    -numa node,nodeid=1,cpus=2-3,memdev=m1 \
    -device pcie-root-port,id=pci-root,slot=4,bus=pcie.0,chassis=0 \
    -device pcie-root-port,id=pci-root-net,chassis=5,slot=5,bus=pcie.0 \
    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
    -device cxl-rp,port=0,id=root_port13,bus=cxl.1,chassis=0,slot=2 \
    -device cxl-rp,port=3,id=root_port14,bus=cxl.1,chassis=2,slot=4 \
    -object memory-backend-ram,size=4G,share=on,id=vmem0 \
    -object memory-backend-ram,size=4G,share=on,id=vmem1 \
    -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,program-hdm-decoder=true \
    -device cxl-type3,bus=root_port14,volatile-memdev=vmem1,id=cxl-vmem1,program-hdm-decoder=true \
    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=4G,cxl-fmw.1.interleave-granularity=4k


How to use
  Specify the following parameters when starting QEMU:

  - bios <SeaBIOS binary that includes commit c2a33ad9ad1452e23b41c4ac44a3bc6be8ebc4cf> to ensure that E820_SOFT_RESERVED entries are exposed
  - Add hmat=on to the -machine option [1]
  - Add program-hdm-decoder=true to each -device cxl-type3 option
    [1] On Linux, the kernel first checks E820_SOFT_RESERVED ranges. When multiple CXL Type 3 devices share a contiguous HPA range,
        these ranges tend to be merged into a single region, so the CXL driver cannot reliably initialize per‑device regions based on E820 alone.
        SRAT entries for CXL memory are therefore needed, and the guest seems to discard SRAT when `hmat=on` is not specified,
        so HMAT must be enabled.

QEMU base commit: bddb785e791e415db38884848d068457e226f5e3

TODO
  With the current implementation of this patch, the following configurations are either not supported or have not been sufficiently tested.
  As a result, automatic creation of CXL regions in the guest OS may fail:

  - A CXL persistent memory device is included
  - Interleaved configurations
  - Cases where the memory size specified by CFMWS does not match the size of the CXL Type 3 backend memory
  - Configurations where CXL memory is attached via a switch
  - Multi-target CFMWS environments
  - ARM environments
  - HMAT does not yet include information about CXL memory devices

  The following behaviors are also provisional implementations and may need further refinement:
   - A new NUMA node ID is assigned to each CXL memory device. This should be improved either to reflect more accurate NUMA distances for CXL memory,
     or to allow the NUMA node IDs to be specified by the user.
   - Assignment of CXL Type 3 devices to CFMWS address ranges. On physical systems, platform firmware typically generates CFMWS entries
     based on the detected CXL topology and its address-space allocation. In QEMU, however, CFMWS entries are configured explicitly
     through machine options. The current implementation therefore has to infer which CFMWS range should be used for each Type 3 device.
     This selection logic may need further refinement. Possible approaches include improving the selection and validation logic,
     adding an explicit option to associate each Type 3 device with a CFMWS entry,
     or generating CFMWS entries automatically from the configured CXL topology and devices.
   - HDM decoder reset sequencing and state reconstruction.
     The current implementation prevents the host bridge HDM decoder configuration from being overwritten later in the same reset
     by moving the common initialization of the host bridge component registers from the reset path to the realization path.
     However, ideally, after the registers have been restored to their reset values, the host bridge HDM decoder configuration
     automatically programmed by QEMU should be reconstructed as part of reset processing.

Thanks,

------

Yukiya Takaki (7):
  QEMU/hw/cxl: add program-hdm-decoder option for CXL Type 3 devices
  QEMU/hw/cxl:add HPA offset tracking for CXL Type 3 devices
  QEMU: hw/cxl: add helper to get HPA range for CXL Type 3
  QEMU/hw/cxl: auto‑program HDM decoders for CXL Type 3
  QEMU/hw/cxl: expose CXL Type 3 ranges as E820_SOFT_RESERVED on x86
  QEMU/hw/cxl: Create NUMA nodes for CXL Type 3 memory
  add CXL Type 3 memory ranges to SRAT

 hw/acpi/cxl_type3.c                 |  30 +++++
 hw/acpi/meson.build                 |   1 +
 hw/arm/cxl.c                        |  10 ++
 hw/arm/meson.build                  |   2 +
 hw/cxl/cxl-host.c                   |  63 ++++++++++
 hw/i386/acpi-build.c                |   7 ++
 hw/i386/cxl.c                       |  11 ++
 hw/i386/meson.build                 |   1 +
 hw/i386/pc.c                        |   2 +
 hw/mem/cxl_type3.c                  | 177 ++++++++++++++++++++++++++++
 hw/pci-bridge/pci_expander_bridge.c |  13 +-
 include/hw/cxl/cxl.h                |   2 +
 include/hw/cxl/cxl_device.h         |   6 +
 include/hw/cxl/cxl_host.h           |   3 +
 include/hw/mem/cxl_type3.h          |   8 ++
 15 files changed, 334 insertions(+), 2 deletions(-)
 create mode 100644 hw/acpi/cxl_type3.c
 create mode 100644 hw/arm/cxl.c
 create mode 100644 hw/i386/cxl.c
 create mode 100644 include/hw/mem/cxl_type3.h

-- 
2.52.0

