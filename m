Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AEA67E6D
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TBK5r0pnfz6D8Yk;
	Fri, 12 Jan 2024 19:28:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A746140B73;
	Fri, 12 Jan 2024 19:30:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Jan
 2024 11:30:24 +0000
Date: Fri, 12 Jan 2024 11:30:23 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, "Huang, Ying"
	<ying.huang@intel.com>, <linux-cxl@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v3 3/3] cxl: Add memory hotplug notifier for cxl region
Message-ID: <20240112113023.00006c50@Huawei.com>
In-Reply-To: <6132c975-3208-40f4-a710-b7b7dac608a1@intel.com>
References: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
	<170441211484.3574076.5894396662836000435.stgit@djiang5-mobl3>
	<87r0is9v6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240108121538.00001369@Huawei.com>
	<38be52cf-a4ea-402c-9b14-47a80427f0c8@intel.com>
	<20240109162753.00005b2b@Huawei.com>
	<659d9e563e1fd_24a8294b7@dwillia2-xfh.jf.intel.com.notmuch>
	<20240110100048.000062c0@Huawei.com>
	<6132c975-3208-40f4-a710-b7b7dac608a1@intel.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 10 Jan 2024 08:27:57 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 1/10/24 03:00, Jonathan Cameron wrote:
> > On Tue, 9 Jan 2024 11:28:22 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> >> Jonathan Cameron wrote:  
> >>> On Mon, 8 Jan 2024 11:18:33 -0700
> >>> Dave Jiang <dave.jiang@intel.com> wrote:
> >>>     
> >>>> On 1/8/24 05:15, Jonathan Cameron wrote:    
> >>>>> On Mon, 08 Jan 2024 14:49:03 +0800
> >>>>> "Huang, Ying" <ying.huang@intel.com> wrote:
> >>>>>       
> >>>>>> Dave Jiang <dave.jiang@intel.com> writes:
> >>>>>>      
> >>>>>>> When the CXL region is formed, the driver would computed the performance
> >>>>>>> data for the region. However this data is not available at the node data
> >>>>>>> collection that has been populated by the HMAT during kernel
> >>>>>>> initialization. Add a memory hotplug notifier to update the performance
> >>>>>>> data to the node hmem_attrs to expose the newly calculated region
> >>>>>>> performance data. The CXL region is created under specific CFMWS. The
> >>>>>>> node for the CFMWS is created during SRAT parsing by acpi_parse_cfmws().
> >>>>>>> Additional regions may overwrite the initial data, but since this is
> >>>>>>> for the same proximity domain it's a don't care for now.
> >>>>>>>
> >>>>>>> node_set_perf_attrs() symbol is exported to allow update of perf attribs
> >>>>>>> for a node. The sysfs path of
> >>>>>>> /sys/devices/system/node/nodeX/access0/initiators/* is created by
> >>>>>>> ndoe_set_perf_attrs() for the various attributes where nodeX is matched
> >>>>>>> to the proximity domain of the CXL region.      
> >>>>>
> >>>>> As per discussion below.  Why is access1 not also relevant for CXL memory?
> >>>>> (it's probably more relevant than access0 in many cases!)
> >>>>>
> >>>>> For historical references, I wanted access0 to be the CPU only one, but
> >>>>> review feedback was that access0 was already defined as 'initiator based'
> >>>>> so we couldn't just make the 0 indexed one the case most people care about.
> >>>>> Hence we grew access1 to cover the CPU only case which most software cares
> >>>>> about.
> >>>>>       
> >>>>>>>
> >>>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>>>>> Cc: Rafael J. Wysocki <rafael@kernel.org>
> >>>>>>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> >>>>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >>>>>>> ---
> >>>>>>> v3:
> >>>>>>> - Change EXPORT_SYMBOL_NS_GPL(,CXL) to EXPORT_SYMBOL_GPL() (Jonathan)
> >>>>>>> - use read_bandwidth as check for valid coords (Jonathan)
> >>>>>>> - Remove setting of coord access level 1. (Jonathan)
> >>>>>>> ---
> >>>>>>>  drivers/base/node.c       |    1 +
> >>>>>>>  drivers/cxl/core/region.c |   42 ++++++++++++++++++++++++++++++++++++++++++
> >>>>>>>  drivers/cxl/cxl.h         |    3 +++
> >>>>>>>  3 files changed, 46 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/drivers/base/node.c b/drivers/base/node.c
> >>>>>>> index cb2b6cc7f6e6..48e5cb292765 100644
> >>>>>>> --- a/drivers/base/node.c
> >>>>>>> +++ b/drivers/base/node.c
> >>>>>>> @@ -215,6 +215,7 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
> >>>>>>>  		}
> >>>>>>>  	}
> >>>>>>>  }
> >>>>>>> +EXPORT_SYMBOL_GPL(node_set_perf_attrs);
> >>>>>>>  
> >>>>>>>  /**
> >>>>>>>   * struct node_cache_info - Internal tracking for memory node caches
> >>>>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> >>>>>>> index d28d24524d41..bee65f535d6c 100644
> >>>>>>> --- a/drivers/cxl/core/region.c
> >>>>>>> +++ b/drivers/cxl/core/region.c
> >>>>>>> @@ -4,6 +4,7 @@
> >>>>>>>  #include <linux/genalloc.h>
> >>>>>>>  #include <linux/device.h>
> >>>>>>>  #include <linux/module.h>
> >>>>>>> +#include <linux/memory.h>
> >>>>>>>  #include <linux/slab.h>
> >>>>>>>  #include <linux/uuid.h>
> >>>>>>>  #include <linux/sort.h>
> >>>>>>> @@ -2972,6 +2973,42 @@ static int is_system_ram(struct resource *res, void *arg)
> >>>>>>>  	return 1;
> >>>>>>>  }
> >>>>>>>  
> >>>>>>> +static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
> >>>>>>> +					  unsigned long action, void *arg)
> >>>>>>> +{
> >>>>>>> +	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
> >>>>>>> +					       memory_notifier);
> >>>>>>> +	struct cxl_region_params *p = &cxlr->params;
> >>>>>>> +	struct cxl_endpoint_decoder *cxled = p->targets[0];
> >>>>>>> +	struct cxl_decoder *cxld = &cxled->cxld;
> >>>>>>> +	struct memory_notify *mnb = arg;
> >>>>>>> +	int nid = mnb->status_change_nid;
> >>>>>>> +	int region_nid;
> >>>>>>> +
> >>>>>>> +	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
> >>>>>>> +		return NOTIFY_DONE;
> >>>>>>> +
> >>>>>>> +	region_nid = phys_to_target_node(cxld->hpa_range.start);
> >>>>>>> +	if (nid != region_nid)
> >>>>>>> +		return NOTIFY_DONE;
> >>>>>>> +
> >>>>>>> +	/* Don't set if there's no coordinate information */
> >>>>>>> +	if (!cxlr->coord.write_bandwidth)
> >>>>>>> +		return NOTIFY_DONE;        
> >>>>>>
> >>>>>> Although you said you will use "read_bandwidth" in changelog, you
> >>>>>> actually didn't do that.
> >>>>>>      
> >>>>>>> +
> >>>>>>> +	node_set_perf_attrs(nid, &cxlr->coord, 0);
> >>>>>>> +	node_set_perf_attrs(nid, &cxlr->coord, 1);        
> >>>>>>
> >>>>>> And this.
> >>>>>>
> >>>>>> But I don't think it's good to remove access level 1.  According to
> >>>>>> commit b9fffe47212c ("node: Add access1 class to represent CPU to memory
> >>>>>> characteristics").  Access level 1 is for performance from CPU to
> >>>>>> memory.  So, we should keep access level 1.  For CXL memory device,
> >>>>>> access level 0 and access level 1 should be equivalent.  Will the code
> >>>>>> be used for something like GPU connected via CXL?  Where the access
> >>>>>> level 0 may be for the performance from GPU to the memory.
> >>>>>>      
> >>>>> I disagree. They are no more equivalent than they are on any other complex system.
> >>>>>
> >>>>> e.g. A CXL root port being described using generic Port infrastructure may be
> >>>>> on a different die (IO dies are a common architecture) in the package
> >>>>> than the CPU cores and that IO die may well have generic initiators that
> >>>>> are much nearer than the CPU cores.
> >>>>>
> >>>>> In those cases access0 will cover initators on the IO die but access1 will
> >>>>> cover the nearest CPU cores (initiators).
> >>>>>
> >>>>> Both should arguably be there for CXL memory as both are as relevant as
> >>>>> they are for any other memory.
> >>>>>
> >>>>> If / when we get some GPUs etc on CXL that are initiators this will all
> >>>>> get a lot more fun but for now we can kick that into the long grass.      
> >>>>
> >>>>
> >>>> With the current way of storing HMAT targets information, only the
> >>>> best performance data is stored (access0). The existing HMAT handling
> >>>> code also sets the access1 if the associated initiator node contains
> >>>> a CPU for conventional memory. The current calculated full CXL path
> >>>> is the access0 data. I think what's missing is the check to see if
> >>>> the associated initiator node is also a CPU node and sets access1
> >>>> conditionally based on that. Maybe if that conditional gets added
> >>>> then that is ok for what we have now?    
> >>>
> >>> You also need the access1 initiators to be figured out (nearest
> >>> one that has a CPU) - so two separate sets of calculations.
> >>> Could short cut the maths if they happen to be the same node of
> >>> course.    
> >>
> >> Where is "access1" coming from? The generic port is the only performance
> >> profile that is being calculated by the CDAT code and there is no other
> >> initiator.  
> > 
> > This isn't about initiators on the CXL side of the port (for now anyway).
> > It's about intiators in the host system.
> >   
> >>
> >> Now if "access1" is a convention of "that's the CPU" then we should skip
> >> emitting access0 altogether and reserve that for some future accelerator
> >> case that can define a better access profile talking to its own local
> >> memory.  Otherwise having access0 and access1 when the only initiator is
> >> the generic port (which includes all CPUs attached to that generic port)
> >> does not resolve for me.  
> > 
> > The initiators here are:
> > 
> > * CPUs in the host - due to limitations of the HMAT presentation that actually
> >   means those CPUs in the host that are nearest to the generic port. Only
> >   these are considered for access1. So for simple placement decisions on
> >   CPU only workloads this is what matters.
> > * Other initiators in the host such NICs on PCI (typically ones that
> >   are presented at RCiEPs or behind 'fake' switches but actually in the same
> >   die as the root complex)  These and CPUs are included for access0
> > * (not supported yet). Other initiators in the CXL fabric.
> > 
> > My ancient white paper needs an update to include generic ports as they do
> > make things more complex.
> > https://github.com/hisilicon/acpi-numa-whitepaper/releases/download/v0.93/NUMA_Description_Under_ACPI_6.3_v0.93.pdf
> > 
> > Anyhow:  ASCI art time. (simplified diagram of an old production CPU with CXL added
> > where the PCI RC is - so no future product info but expect to see systems that
> > looks similar to this :))
> > 
> > Note the IO die might also be in the middle, or my "favorite" design - in a separate
> > package entirely - IO expanders on the inter socket interconnect - (UPI or similar) ;)
> > Note these might not be physical systems - an example is a VM workload
> > which occasionally needs to use an 'extra' GPU. That GPU comes from a host socket
> > on which the VM has no CPU resources or memory.  Anyhow given the diagrams
> > I've seen of production systems pretty much anything you can conceive is is being
> > built by someone.
> > 
> >         ________________      __________________
> >        |                |    |                  |            
> >        |  Host DDR(PXM0)|    |  Host DDR (PXM1) |
> >        |________________|    |__________________|
> >               |                       |
> >        _______|_______         _______|____        _________________
> >        |              |       |            |       |                | 
> >        |   CPU Die    |-------|  CPU Die   |-------|  IO DIE        |
> >        |   PXM 0      |       |  PXM 1     |       |  PXM 2         |
> >        |              |       |            |       |  NIC (GP + GI) |
> >        |______________|       |____________|       |________________|
> >                                                            |
> >                                                     _______|________
> >                                                    |               |
> >                                                    |   CXL Mem     |
> >                                                    |               |
> >                                                    |_______________|
> > 
> > So in this case access0 should have PXM2 as the initiator and include
> > the bandwidth and latency numbers from PXM2 to itself (where the GP is)
> > and those to the CXL memory that Dave's code adds in.
> > 
> > Access1 is from PXM1 to PXM2 (to get to the GP) and on to the CXL mem.
> > 
> > Note that one reason to do this is that the latency from the NIC in PXM2
> > to CXL mem might well be not much worse than from it to the memory on PXM 1
> > (cpu Die) so placement decisions might favor putting NIC buffers in CXL mem
> > particularly if the bandwidth is good.
> > 
> > 
> >   
> >>  
> >>>> If/When the non-CPU initiators shows up for CXL, we'll need to change
> >>>> the way to store the initiator to generic target table data and how
> >>>> we calculate and setup access0 vs access1. Maybe that can be done as
> >>>> a later iteration?    
> >>>
> >>> I'm not that bothered yet about CXL initiators - the issue today
> >>> is ones on a different node the host side of the root ports.
> >>>
> >>> For giggles the NVIDIA Grace proposals for how they manage their
> >>> GPU partitioning will create a bunch of GI nodes that may well
> >>> be nearer to the CXL ports - I've no idea!
> >>> https://lore.kernel.org/qemu-devel/20231225045603.7654-1-ankita@nvidia.com/    
> >>
> >> It seems sad that we, as an industry, went through all this trouble to
> >> define an enumerable CXL bus only to fall back to ACPI for enumeration.  
> > 
> > History - a lot of this stuff was in design before CXL surfaced.
> > I think we are all pushing for people to reuse the CXL defined infrastructure
> > (or similar) in the long term to make everything enumerable.
> > 
> > Arguably for a host system ACPI is the enumeration method...
> > 
> >   
> >>
> >> The Linux reaction to CFMWS takes a "Linux likely needs *at least* this many
> >> memory target nodes considered at the beginning of time", with a "circle
> >> back to the dynamic node creation problem later if it proves to be
> >> insufficient". The NVIDIA proposal appears to be crossing that
> >> threshold, and I will go invite them to do the work to dynamically
> >> enumerate initiators into the Linux tracking structures.  
> > 
> > Absolutely - various replies in earlier threads made that point
> > (and that everyone has been kicking that tire down the road for years).
> >   
> >>
> >> As for where this leaves this patchset, it is clear from this
> >> conversation that v6.9 is a better target for clarifying this NUMA
> >> information, but I think it is ok to move ahead with the base CDAT
> >> parsing for v6.8 (the bits that are already exposed to linux-next). Any
> >> objections?
> >>  
> > Should be fine if we keep away from the userspace exposed new bits
> > (though I think we can clarify them fairly fast - it's a bit late ;(  
> 
> The only exposure to user space is the QTG ID (qos_class) based on access0 generic target numbers.

That's a fun corner case.   Which one is appropriate? My gut feeling is access1
but if the GI is in the host, then the QOS may want to reflect that. If the GI
is on the CXL bus then whether host QOS matters is dependent on whether P2P is
going on and where the bottleneck that is driving the QOS decisions in the host
is.

Let us cross our fingers that that this never matters in practice.  I can't
face trying to get a clarification on this in appropriate standards groups given
it's all a bit hypothetical for QOS (hence QTG selection) at least.

Jonathan

> > 
> > Jonathan
> > 
> >   

