Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEBC78F37;
	Thu, 13 Mar 2025 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741847643; cv=none; b=jBHDqRwtDjW31wbgaQDyXFqhEPZvDS+bbEp2EM/ZG5VBwhZxfQHlrf8rXHQiU9c166ZBoiHkbtksg6oLmDUXsY2u3TmgUOuDgHJBwaxtTYe6SFHA01OVQBX5N1EM9dN4ntVNKarLq2Enjow7L3mD35Rrb0Y03bxL+CNfwNLCKWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741847643; c=relaxed/simple;
	bh=g+pYZb1R6pbeBAW2lar/FpB72doB1VzuhQCzJhTiULI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRYSn04fSDdO0hblOrpKehVxttY1RWm0T2aL+k3Ei61T4E5BAHAb6Part6KLyc4Eo4mWLlt3FCZwzlkpUMzaC/T3jmh9zbs5MIbFgN+vrP2RelUqzP2HS7o9zwxSqPRzAeE1DCvrE2nxtmomHdCl81+odF35+g4H5Qf7dqUSvug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-98-67d27c53c7e1
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH v2 2/4] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Thu, 13 Mar 2025 15:33:37 +0900
Message-ID: <20250313063351.692-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z9GwNWNC9VfR3Y6A@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsXC9ZZnoW5wzaV0gwt3JC3mrF/DZjF96gVG
	i593j7NbHN86j93i/KxTLBaXd81hs7i35j+rxeo1GQ4cHjtn3WX36G67zO6xeM9LJo9Nnyax
	e5yY8ZvFY+dDS4/Pm+QC2KO4bFJSczLLUov07RK4Mlp2aBU0GVcce/GbvYFxqkYXIyeHhICJ
	xJbH35hg7FNv1zB2MXJwsAkoSRzbGwNiigioSrRdce9i5OJgFljPJPF60yw2kLiwQLjE8bdV
	IJ0sQCW/z79mBLF5BYwlWpv/sEBM1JRouHSPCaScU8BMYuPyPJCwkACPxKsN+6HKBSVOznwC
	Vs4sIC/RvHU2M0TrCTaJLacCIWxJiYMrbrBMYOSfhaRlFpKWBYxMqxiFMvPKchMzc0z0Mirz
	Miv0kvNzNzECw3dZ7Z/oHYyfLgQfYhTgYFTi4U2YfDFdiDWxrLgy9xCjBAezkgjvatsL6UK8
	KYmVValF+fFFpTmpxYcYpTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYmw0kGTPsFuw+
	FVc9c8L0uFqJP6tVzfk9NjRMPnPTVVzbgmNfZcqN4H0Bp1cHrz3StzKmpWCm8synES6rGPVd
	+nJPs28r75HV+7NI9iSrttnngve9Ouu+rVzzP8mf9XNu1zl/q6PCEv5Mrn0zV/hvZHnuO2t/
	pGb9+/j5asIK+Qf41abEu/UpsRRnJBpqMRcVJwIAOG103lsCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsXCNUNNSze45lK6wbd1ghZz1q9hs5g+9QKj
	xc+7x9ktPj97zWxxfOs8dovDc0+yWpyfdYrF4vKuOWwW99b8Z7U4dO05q8XqNRkWv7etYHPg
	8dg56y67R3fbZXaPxXteMnls+jSJ3ePEjN8sHjsfWnp8u+3hsfjFByaPz5vkAjijuGxSUnMy
	y1KL9O0SuDJadmgVNBlXHHvxm72BcapGFyMnh4SAicSpt2sYuxg5ONgElCSO7Y0BMUUEVCXa
	rrh3MXJxMAusZ5J4vWkWG0hcWCBc4vjbKpBOFqCS3+dfM4LYvALGEq3Nf1ggJmpKNFy6xwRS
	zilgJrFxeR5IWEiAR+LVhv1Q5YISJ2c+AStnFpCXaN46m3kCI88sJKlZSFILGJlWMYpk5pXl
	JmbmmOoVZ2dU5mVW6CXn525iBAbtsto/E3cwfrnsfohRgINRiYc3YfLFdCHWxLLiytxDjBIc
	zEoivKttL6QL8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1
	ME6UupNreChILlN9s+/psHVhhi+Ur75/Yf3z9rvZq/Zma2sf+rlCermF97XixHXvf8Rc5HOu
	8Ug97aEp4veNRbTm7J3mzbPST+7+m7ivZun8e1N71eQj4piYvuiGK+3+nLmT4/OMZ63rC1U5
	proF+Fferd1WZeiz465ZFlvD8lzm16tO/up/F6fEUpyRaKjFXFScCACF+M0DVgIAAA==
X-CFilter-Loop: Reflected

On Wed, 12 Mar 2025 12:03:01 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Wed, Mar 12, 2025 at 04:56:25PM +0900, Rakie Kim wrote:
> > The weighted interleave policy distributes page allocations across multiple
> > NUMA nodes based on their performance weight, thereby optimizing memory
> > bandwidth utilization. The weight values for each node are configured
> > through sysfs.
> > 
> > Previously, the sysfs entries for configuring weighted interleave were only
> > created during initialization. This approach had several limitations:
> > - Sysfs entries were generated for all possible nodes at boot time,
> >   including nodes without memory, leading to unnecessary sysfs creation.
> 
> It's not that it's unnecessary, it's that it allowed for configuration
> of nodes which may not have memory now but may have memory in the
> future.  This was not well documented.

I will update the commit message to reflect your feedback.

> 
> > - Some memory devices transition to an online state after initialization,
> >   but the existing implementation failed to create sysfs entries for
> >   these dynamically added nodes. As a result, memory hotplugged nodes
> >   were not properly recognized by the weighed interleave mechanism.
> > 
> 
> The current system creates 1 node per N_POSSIBLE nodes, and since nodes
> can't transition between possible and not-possible your claims here are
> contradictory.
> 
> I think you mean that simply switching from N_POSSIBLE to N_MEMORY is
> insufficient since nodes may transition in and out of the N_MEMORY
> state.  Therefore this patch utilizes a hotplug callback to add and
> remove sysfs entries based on whether a node is in the N_MEMORY set.

I will update the commit message to reflect your feedback.

> 
> > To resolve these issues, this patch introduces two key improvements:
> > 1) At initialization, only nodes that are online and have memory are
> >    recognized, preventing the creation of unnecessary sysfs entries.
> > 2) Nodes that become available after initialization are dynamically
> >    detected and integrated through the memory hotplug mechanism.
> > 
> > With this enhancement, the weighted interleave policy now properly supports
> > memory hotplug, ensuring that newly added nodes are recognized and sysfs
> > entries are created accordingly.
> >
> 
> It doesn't "support memory hotplug" so much as it "Minimizes weighted
> interleave to exclude memoryless nodes".

I will update the commit message to reflect your feedback.

> 
> > Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> > ---
> >  mm/mempolicy.c | 47 ++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 42 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 1691748badb2..94efff89e0be 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -113,6 +113,7 @@
> >  #include <asm/tlbflush.h>
> >  #include <asm/tlb.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/memory.h>
> >  
> >  #include "internal.h"
> >  
> > @@ -3489,9 +3490,38 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
> >  	return 0;
> >  }
> >  
> > +struct kobject *wi_kobj;
> > +
> > +static int wi_node_notifier(struct notifier_block *nb,
> > +			       unsigned long action, void *data)
> > +{
> > +	int err;
> > +	struct memory_notify *arg = data;
> > +	int nid = arg->status_change_nid;
> > +
> > +	if (nid < 0)
> > +		goto notifier_end;
> > +
> > +	switch(action) {
> > +	case MEM_ONLINE:
> > +		err = add_weight_node(nid, wi_kobj);
> > +		if (err) {
> > +			pr_err("failed to add sysfs [node%d]\n", nid);
> > +			kobject_put(wi_kobj);
> > +			return NOTIFY_BAD;
> > +		}
> > +		break;
> > +	case MEM_OFFLINE:
> > +		sysfs_wi_node_release(node_attrs[nid], wi_kobj);
> > +		break;
> > +	}
> 
> I'm fairly certain this logic is wrong.  If I add two memory blocks and
> then remove one, would this logic not remove the sysfs entries despite
> there being a block remaining?

Regarding the assumption about node configuration:
Are you assuming that a node has two memory blocks and that
MEM_OFFLINE is triggered when one of them is offlined? If so, then
you are correct that this logic would need modification.

I performed a simple test by offlining a single memory block:
# echo 0 > /sys/devices/system/node/node2/memory100/online

In this case, MEM_OFFLINE was not triggered. However, I need to
conduct further analysis to confirm this behavior under different
conditions. I will review this in more detail and share my
findings, including the test methodology and results.

> 
> > +
> > +notifier_end:
> > +	return NOTIFY_OK;
> > +}
> > +
> >  static int add_weighted_interleave_group(struct kobject *root_kobj)
> >  {
> > -	struct kobject *wi_kobj;
> >  	int nid, err;
> >  
> >  	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> > @@ -3505,16 +3535,23 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
> >  		return err;
> >  	}
> >  
> > -	for_each_node_state(nid, N_POSSIBLE) {
> > +	for_each_online_node(nid) {
> > +		if (!node_state(nid, N_MEMORY))
> 
> Rather than online node, why not just add for each N_MEMORY node -
> regardless of if its memory is online or not?  If the memory is offline,
> then it will be excluded from the weighted interleave mechanism by
> nature of the node being invalid for allocations anyway.

Regarding the decision to check both N_MEMORY and N_ONLINE:
This was done to ensure consistency with the conditions under which
`wi_node_notifier` is triggered. Specifically, `MEM_ONLINE` is called
only when a node is in both the N_MEMORY and N_ONLINE states.

I will review this logic further. If my understanding is correct,
keeping the current implementation is the appropriate approach.
However, I will conduct additional testing to validate this and
provide further updates accordingly.

> 
> > +			continue;
> > +
> >  		err = add_weight_node(nid, wi_kobj);
> >  		if (err) {
> >  			pr_err("failed to add sysfs [node%d]\n", nid);
> > -			break;
> > +			goto err_out;
> >  		}
> >  	}
> > -	if (err)
> > -		kobject_put(wi_kobj);
> > +
> > +	hotplug_memory_notifier(wi_node_notifier, DEFAULT_CALLBACK_PRI);
> >  	return 0;
> > +
> > +err_out:
> > +	kobject_put(wi_kobj);
> > +	return err;
> >  }
> >  
> >  static void mempolicy_kobj_release(struct kobject *kobj)
> > -- 
> > 2.34.1
> > 
