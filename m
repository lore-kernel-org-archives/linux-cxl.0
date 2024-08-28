Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE04B13C3D5
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864430; cv=none; b=BdDzaEv5E87OOgG/pfJ+H609BVD+CO5k82+WSqcvTffCo7Wj/CsCgTh9sN7TRdKuSyX0DVSrp95pWRIYu6qRUeZJDkwWvv6hSb1gtRAkQqhNaw35OtYdwViBBvMBzt0Ak0txRGiusGjy5c03vZQZF9QXnV9r1T2XkPCfuLZn3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864430; c=relaxed/simple;
	bh=8lq6D+TnMA8NyDmoXQ8B3F4kjjBDTHjVDBrvKlj6CWs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iS+HSfz06Ga+bIldRpm2CgWsAOvAjO3/DIiUgmDpCCPuwY3+gvCnQQABGLioungjYyOj7UocbtIYh4F/0J7m11tWmwjnnRC6COsm6ncCLtnXbIM+ay+r8PfLZP+JNOn8xrREcIbWKCs9s+WscDKSkesLnGtFvWsj/hQhq5m69GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv9Y223pTz6K6SY;
	Thu, 29 Aug 2024 00:56:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AFEE140A87;
	Thu, 29 Aug 2024 01:00:24 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 18:00:23 +0100
Date: Wed, 28 Aug 2024 18:00:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>, <linuxarm@huawei.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Huang
 Ying" <ying.huang@intel.com>, Michael Roth <michael.roth@amd.com>,
	<fan.ni@samsung.com>
Subject: Re: [RFC qemu 0/6] hw/cxl: Link speed and width control
Message-ID: <20240828175943.00001ff3@huawei.com>
In-Reply-To: <20240712122414.1448284-1-Jonathan.Cameron@huawei.com>
References: <20240712122414.1448284-1-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 12 Jul 2024 13:24:08 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Based-on: [PATCH v5 00/13] acpi: NUMA nodes for CXL HB as GP + complex NUMA test
> Based-on: Message-ID: 20240712110837.1439736-1-Jonathan.Cameron@huawei.com

Hi All,

I'd like to get this missing piece in 9.2.  So if anyone has time to give
it a quick look that would be much appreciated as then it may be
in a good state nice and early in the cycle. In particular the question
below.

If not I'll send a non RFC version early in the 9.2 cycle and see if that
gets more reaction.  I fully appreciate people are busy!

This support is proving helpful for testing the improved kernel handling
to deal with bottlenecks in shared links and I'd like to have an upstream
QEMU path for testing the full discoverable latency + bandwidth from
CPUs (and similar) part of CXL that's needed for tiered memory management.

Jonathan
> 
> The Generic Ports support added the ability to describe the bandwidth and
> Latency within a host to a CXL host bridge.  To be able to test the of the
> discovery path used by Linux [1] we also need to be able to create
> bottlenecks at difference places in the topology. There are two parts to
> this
> * CXL link characteristics as described by PCI Express Capability Link
>   status etc.
> * Bandwidth and latency across CXL Switches (via CDAT data from the switch
>   USP)
> * Bandwidth and latency from the CXL type 3 device port to the actual
>   memory (Via CDAT data from the EP).
> 
> Currently we have fixed values for the CXL CDAT tables, and to test this
> I recommend changing those as per the patch at the end of this cover letter
> (so they aren't always the bottleneck). Making those configurable will be
> handled in a future patch set.
> 
> RFC question:
> - I could enable this for all PCIe device (including ports).
>   Does that makes sense, or is it better to limit this to my cases.
>   It is quite easy to build broken setups (downstream device reports
>   faster link than the port etc) because QEMU 'link' training' is
>   simplistic.  I'm not sure it is worth making it more clever.
> 
> Test case snippets I promised Dave Jiang. These rely on the tweaks to
> CDAT at end of this cover letter.
> 
> Case 1:  Direct connected pair of type 3 nodes on same HB - type 3 limited
> ==========================================================================
> 
>  -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/t3_cxl1.raw,size=1G,align=256M \
>  -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/t3_cxl2.raw,size=1G,align=256M \
>  -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/t3_lsa1.raw,size=1M,align=1M \
>  -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/t3_cxl3.raw,size=1G,align=256M \
>  -object memory-backend-file,id=cxl-mem4,share=on,mem-path=/tmp/t3_cxl4.raw,size=1G,align=256M \
>  -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/t3_lsa2.raw,size=1M,align=1M \
>  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true,numa_node=0 \
>  -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
>  -device cxl-rp,port=1,bus=cxl.1,id=cxl_rp_port1,chassis=0,slot=3 \
>  -device cxl-type3,bus=cxl_rp_port0,volatile-memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3,x-speed=32,x-width=16 \
>  -device cxl-type3,bus=cxl_rp_port1,volatile-memdev=cxl-mem3,id=cxl-pmem2,lsa=cxl-lsa2,sn=5,x-speed=32,x-width=16 \
>  -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=8G,cxl-fmw.0.interleave-granularity=1k \
>  -numa node,nodeid=0,cpus=0-3,memdev=mem0 \
>  -numa node,nodeid=1 \
>  -object acpi-generic-initiator,id=bob2,pci-dev=bob,node=1 \
>  -numa node,nodeid=2 \
>  -object acpi-generic-port,id=bob11,pci-bus=cxl.1,node=2 \
>  -numa dist,src=0,dst=0,val=10 -numa dist,src=0,dst=1,val=21 -numa dist,src=0,dst=2,val=21 \
>  -numa dist,src=1,dst=0,val=21 -numa dist,src=1,dst=1,val=10 -numa dist,src=1,dst=2,val=21 \
>  -numa dist,src=2,dst=0,val=21 -numa dist,src=2,dst=1,val=21 -numa dist,src=2,dst=2,val=10 \
>  -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=10 \
>  -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=3G \
>  -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-latency,latency=100 \
>  -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=100G \
>  -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-latency,latency=500 \
>  -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=100M \
>  -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-latency,latency=50 \
>  -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=100G
> 
> Set x-width to 2 and it will be link limited.
> 
>  -device cxl-type3,bus=cxl_rp_port0,volatile-memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3,x-speed=32,x-width=2 \
>  -device cxl-type3,bus=cxl_rp_port1,volatile-memdev=cxl-mem3,id=cxl-pmem2,lsa=cxl-lsa2,sn=5,x-speed=32,x-width=2 \
> 
> Case 2: Switch connected type 3.
> ================================
> 
>  -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/t3_cxl1.raw,size=1G,align=256M \
>  -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/t3_cxl3.raw,size=1G,align=256M \
>  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
>  -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2,mem-reserve=128M,hotplug=true \
>  -device cxl-upstream,port=33,bus=cxl_rp_port0,id=us0,multifunction=on,addr=0.0,sn=33,x-speed=64,x-width=16 \
>  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4,hotplug=true \
>  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5,hotplug=true \
>  -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem1,id=cxl-pmem1,sn=3,x-speed=32,x-width=16 \
>  -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem3,id=cxl-pmem2,sn=5,x-speed=32,x-width=16 \
>  -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
>  -numa node,nodeid=0,cpus=0-3,memdev=mem0 \
>  -numa node,nodeid=1 \
>  -object acpi-generic-initiator,id=bob2,pci-dev=bob,node=1 \
>  -numa node,nodeid=2 \
>  -object acpi-generic-port,id=bob11,pci-bus=cxl.1,node=2 \
>  -numa dist,src=0,dst=0,val=10 -numa dist,src=0,dst=1,val=21 -numa dist,src=0,dst=2,val=21 \
>  -numa dist,src=1,dst=0,val=21 -numa dist,src=1,dst=1,val=10 -numa dist,src=1,dst=2,val=21 \
>  -numa dist,src=2,dst=0,val=21 -numa dist,src=2,dst=1,val=21 -numa dist,src=2,dst=2,val=10 \
>  -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=10 \
>  -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=800M \
>  -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-latency,latency=100 \
>  -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=200G \
>  -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-latency,latency=500 \
>  -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=100M \
>  -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-latency,latency=50 \
>  -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=200G
> 
> Starting from this and...
> * Changing links for the two type 3 devices to x-speed=16,x-width=4 will make it leaf
>   link limited.
> * Changing link for the USP to x-speed=32,x-width=8 will make it head link limited.
> 
> Case 3: 2 GP, 2 HB, direct connected type 3.
> ============================================
> 
> GP limited configuration (found bug in v6 of kernel series)
> 
>  -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/t3_cxl1.raw,size=1G,align=256M \
>  -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/t3_cxl2.raw,size=1G,align=256M \
>  -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/t3_lsa1.raw,size=1M,align=1M \
>  -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/t3_cxl3.raw,size=1G,align=256M \
>  -object memory-backend-file,id=cxl-mem4,share=on,mem-path=/tmp/t3_cxl4.raw,size=1G,align=256M \
>  -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/t3_lsa2.raw,size=1M,align=1M \
>  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true,numa_node=2 \
>  -device pxb-cxl,bus_nr=22,bus=pcie.0,id=cxl.2,hdm_for_passthrough=true,numa_node=3 \
>  -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
>  -device cxl-rp,port=1,bus=cxl.2,id=cxl_rp_port1,chassis=0,slot=3 \
>  -device cxl-type3,bus=cxl_rp_port0,volatile-memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3,x-speed=32,x-width=16 \
>  -device cxl-type3,bus=cxl_rp_port1,volatile-memdev=cxl-mem3,id=cxl-pmem2,lsa=cxl-lsa2,sn=5,x-speed=32,x-width=16 \
>  -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.targets.1=cxl.2,cxl-fmw.0.size=8G,cxl-fmw.0.interleave-granularity=1k \
>  -numa node,nodeid=0,cpus=0-3,memdev=mem0 \
>  -numa node,nodeid=1 \
>  -object acpi-generic-initiator,id=bob2,pci-dev=bob,node=1 \
>  -numa node,nodeid=2 \
>  -object acpi-generic-port,id=bob11,pci-bus=cxl.1,node=2 \
>  -numa node,nodeid=3 \
>  -object acpi-generic-port,id=bob12,pci-bus=cxl.2,node=3 \
>  -numa dist,src=0,dst=0,val=10 -numa dist,src=0,dst=1,val=21 -numa dist,src=0,dst=2,val=21 -numa dist,src=0,dst=3,val=21 \
>  -numa dist,src=1,dst=0,val=21 -numa dist,src=1,dst=1,val=10 -numa dist,src=1,dst=2,val=21 -numa dist,src=1,dst=3,val=21 \
>  -numa dist,src=2,dst=0,val=21 -numa dist,src=2,dst=1,val=21 -numa dist,src=2,dst=2,val=10 -numa dist,src=2,dst=3,val=21 \
>  -numa dist,src=3,dst=0,val=21 -numa dist,src=3,dst=1,val=21 -numa dist,src=3,dst=2,val=21 -numa dist,src=3,dst=3,val=10 \
>  -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=10 \
>  -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=3G \
>  -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-latency,latency=100 \
>  -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=13G \
>  -numa hmat-lb,initiator=0,target=3,hierarchy=memory,data-type=access-latency,latency=100 \
>  -numa hmat-lb,initiator=0,target=3,hierarchy=memory,data-type=access-bandwidth,bandwidth=13G \
>  -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-latency,latency=500 \
>  -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=100M \
>  -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-latency,latency=50 \
>  -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=20G \
>  -numa hmat-lb,initiator=1,target=3,hierarchy=memory,data-type=access-latency,latency=50 \
>  -numa hmat-lb,initiator=1,target=3,hierarchy=memory,data-type=access-bandwidth,bandwidth=20G \
> 
> 
> [1] https://lore.kernel.org/linux-cxl/20240710222716.797267-1-dave.jiang@intel.com
> 
> Suggested tweaks to the CDAT values.
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 88f117576d..fe5fc8cb6c 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -109,7 +109,7 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>          .flags = HMAT_LB_MEM_MEMORY,
>          .data_type = HMAT_LB_DATA_READ_BANDWIDTH,
>          .entry_base_unit = 1000, /* GB/s */
> -        .entry[0] = 16,
> +        .entry[0] = 48,
>      };
> 
>      dslbis3 = g_malloc(sizeof(*dslbis3));
> @@ -122,7 +122,7 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>          .flags = HMAT_LB_MEM_MEMORY,
>          .data_type = HMAT_LB_DATA_WRITE_BANDWIDTH,
>          .entry_base_unit = 1000, /* GB/s */
> -        .entry[0] = 16,
> +        .entry[0] = 48,
>      };
> 
>      dsemts = g_malloc(sizeof(*dsemts));
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index 70cb06436d..85b114d3ce 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -319,5 +319,5 @@ static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>          sslbis_bandwidth->sslbe[i] = (CDATSslbe) {
>              .port_x_id = CDAT_PORT_ID_USP,
>              .port_y_id = port_ids[i],
> -            .latency_bandwidth = 16, /* 16 GB/s */
> +            .latency_bandwidth = 128, /* 128 GB/s */
>          };
> 
> Jonathan Cameron (6):
>   hw/pci-bridge/cxl_root_port: Provide x-speed and x-width properties.
>   hw/pci-bridge/cxl_upstream: Provide x-speed and x-width properties.
>   hw/pcie: Factor out PCI Express link register filing common to EP.
>   hw/pcie: Provide a utility function for control of EP / SW USP link
>   hw/mem/cxl-type3: Add properties to control link speed and width
>   hw/pci-bridge/cxl-upstream: Add properties to control link speed and
>     width
> 
>  include/hw/cxl/cxl_device.h               |   4 +
>  include/hw/pci-bridge/cxl_upstream_port.h |   4 +
>  include/hw/pci/pcie.h                     |   2 +
>  hw/mem/cxl_type3.c                        |   6 ++
>  hw/pci-bridge/cxl_downstream.c            |  23 +++--
>  hw/pci-bridge/cxl_root_port.c             |   5 ++
>  hw/pci-bridge/cxl_upstream.c              |   6 ++
>  hw/pci/pcie.c                             | 105 ++++++++++++++--------
>  8 files changed, 103 insertions(+), 52 deletions(-)
> 

