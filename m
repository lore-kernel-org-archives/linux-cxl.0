Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BB2221540;
	Mon, 17 Mar 2025 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199841; cv=none; b=MY1Pmy3/vIaq+vf/FbBGClev5ZjiCmVwKctcA1l8Umzq3ottF4SMMQhZq4faFevUANiRhqnBgkO/vjrB5X2ARmxz4zmpjGL/P+It2Vi6Y/vE2HYBcjgnomIwCImv5bX8gn1dF11bAFRDj9+IjbnkDs7cOpS4yiIoZVc4dCUPz3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199841; c=relaxed/simple;
	bh=cMo/7p8mMP56sAGGwG2IwFQkYoFW5EgknhR18dn5/bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csX1MvZsa/n7GB7FUczXH20LoyZjrMl19d1ne5+CaDGby9uNXsNZyV3AxrJfXExKNSphlTjfm5uUZx6mTGs/oayTT8ooC3EDHP4gD7vogEqQbiCpR+MndjC6vfmhsESSWh+I06SKQ+HRbP5j3ViDcsnwMb8G7WQdiwRoiQzzDkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-bc-67d7dc127398
From: Rakie Kim <rakie.kim@sk.com>
To: David Hildenbrand <david@redhat.com>
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
	Gregory Price <gourry@gourry.net>,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH v2 2/4] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Mon, 17 Mar 2025 17:23:36 +0900
Message-ID: <20250317082342.807-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <e29293fd-b81a-4133-800a-875dcd252d67@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXC9ZZnka7QnevpBuf261nMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvF8a3z2C3OzzrFYnF51xw2i3tr/rNarF6T4cDpsXPWXXaP7rbL7B6L97xk
	8tj0aRK7x4kZv1k8dj609Hi/7yqbx+dNcgEcUVw2Kak5mWWpRfp2CVwZy7o3sxbcVqn4feoD
	SwPjc6kuRk4OCQETie5j65m7GDnA7KXvhEBMNgEliWN7Y0AqRAQ0JDa1bQCq4OJgFrjCJNFy
	dQNYubBAuMTxt1UgNSwCqhJtby4ygti8AsYS9w6/Z4eYrinRcOkeE4jNKWAncePAQbAaIQEe
	iVcb9kPVC0qcnPmEBcRmFpCXaN46G2yXhMBtNolpT9pZIQZJShxccYNlAiP/LCQ9s5D0LGBk
	WsUolJlXlpuYmWOil1GZl1mhl5yfu4kRGNjLav9E72D8dCH4EKMAB6MSD6/B+mvpQqyJZcWV
	uYcYJTiYlUR4WXZcTxfiTUmsrEotyo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgm
	y8TBKdXAmMhWv3nOYxk+1XM+VYqskxeGxU0XE3Ovkn24o/1+X0EEh9f3Deb2PYy9vzJ+RYkY
	8lzLP8HLNId9yasHpfcbjVvsfm30WHv8dMFzC0H3h+18s859DVOui+/od5ypUBgw+8nOk8+d
	ZTemLu99GPL0FV/ntbSqWt3L5q9kXy/0TjbSebr3hIW0EktxRqKhFnNRcSIAbUzvl2gCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsXCNUNNS1fozvV0gyuz1C3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBbHt85jtzg89ySrxflZp1gsLu+aw2Zxb81/VotD156zWqxek2Hx
	e9sKNgdej52z7rJ7dLddZvdYvOclk8emT5PYPU7M+M3isfOhpcf7fVfZPL7d9vBY/OIDk8fn
	TXIBXFFcNimpOZllqUX6dglcGcu6N7MW3Fap+H3qA0sD43OpLkYODgkBE4ml74RATDYBJYlj
	e2O6GDk5RAQ0JDa1bWDuYuTiYBa4wiTRchXE4eAQFgiXOP62CqSGRUBVou3NRUYQm1fAWOLe
	4ffsILaEgKZEw6V7TCA2p4CdxI0DB8FqhAR4JF5t2A9VLyhxcuYTFhCbWUBeonnrbOYJjDyz
	kKRmIUktYGRaxSiSmVeWm5iZY6pXnJ1RmZdZoZecn7uJERjMy2r/TNzB+OWy+yFGAQ5GJR5e
	g/XX0oVYE8uKK3MPMUpwMCuJ8LLsuJ4uxJuSWFmVWpQfX1Sak1p8iFGag0VJnNcrPDVBSCA9
	sSQ1OzW1ILUIJsvEwSnVwLgsIl50cm7+5+JsHV2G0v/dbc4zxfp5pIs+XfBOX9Kl/y7lnrtr
	oGd7S1uvwrmzE5QyjcXDyu9dkDU8aWQsfrTTNDDpeqkbk+v987nyXBw/slkZON/+CX5Q5mmR
	/uCUsvPKuEeb7c9FH9o+OSjtn8JTG9fyDPt7QVMPfdwcb3xoi9jVH1ttlViKMxINtZiLihMB
	5KlrLWICAAA=
X-CFilter-Loop: Reflected

On Fri, 14 Mar 2025 10:17:26 +0100 David Hildenbrand <david@redhat.com> wrote:
> > Hi David,
> 
> Hi :)
> 
> > 
> > I am currently working on adding memory hotplug-related functionality
> > to the weighted interleave feature. While discussing this with Gregory,
> > a question came up. If you happen to know the answer to the following,
> > I would greatly appreciate your input.
> > 
> > I have added the following logic to call add_weight_node when a node
> > transitions to the N_MEMORY state to create a sysfs entry. Conversely,
> > when all memory blocks of a node go offline (!N_MEMORY),
> > I call sysfs_wi_node_release to remove the corresponding sysfs entry.
> > 
> 
> As a spoiler: I don't like how we squeezed the status_change_nid / 
> status_change_nid_normal stuff into the memory notifier that works on a 
> single memory block -> single zone. But decoupling it is not as easy, 
> because we have this status_change_nid vs. status_change_nid_normal thing.
> 
> For the basic "node going offline / node going online", a separate 
> notifier (or separate callbacks) would make at least your use case much 
> clearer.
> 
> The whole "status_change_nid_normal" is only used by slab. I wonder if 
> we could get rid of it, and simply let slab check the relevant 
> zone->present pages when notified about onlining/offlining of a singe 
> memory block.
> 
> Then, we would only have status_change_nid and could just convert that 
> to a NODE_MEM_ONLINE / NODE_MEM_OFFLINE notifier or sth like that.
> 
> Hmmm, if I wouldn't be on PTO, I would prototype that real quick :)

Hi David :)

I completely agree with your perspective on this. Having separate callbacks
for "node going offline/node going online" would certainly lead to clearer
code. For now, I shall proceed with developing the code based on the current
structure. I will also continue monitoring updates related to "node online/
offline" and plan on revising the code once those are integrated.
Thank you for your valuable input on this matter.

> 
> > +static int wi_node_notifier(struct notifier_block *nb,
> > +                              unsigned long action, void *data)
> > +{
> > +       int err;
> > +       struct memory_notify *arg = data;
> > +       int nid = arg->status_change_nid;
> > +
> > +       if (nid < 0)
> > +               goto notifier_end;
> > +
> > +       switch(action) {
> > +       case MEM_ONLINE:
> > +               err = add_weight_node(nid, wi_kobj);
> > +               if (err) {
> > +                       pr_err("failed to add sysfs [node%d]\n", nid);
> > +                       kobject_put(wi_kobj);
> > +                       return NOTIFY_BAD;
> > +               }
> > +               break;
> > +       case MEM_OFFLINE:
> > +               sysfs_wi_node_release(node_attrs[nid], wi_kobj);
> > +               break;
> > +       }
> > +
> > +notifier_end:
> > +       return NOTIFY_OK;
> > +}
> > 
> > One question I have is whether the MEM_OFFLINE action in the code
> > below will be triggered when a node that consists of multiple memory
> > blocks has only one of its memory blocks transitioning to the offline state.
> > 
> 
> node_states_check_changes_offline() should be making sure that that is 
> the case.
> 
> Only if offlining the current block will make the node (all zones) have 
> no present pages any more, then we'll set status_change_nid to >= 0.
> 

Thank you for reviewing this matter.

> 
> > +       int nid = arg->status_change_nid;
> > +
> > +       if (nid < 0)
> > +               goto notifier_end;
> > 
> > Based on my analysis, wi_node_notifier should function as expected
> > because arg->status_change_nid only holds a non-negative value
> > under the following conditions:
> > 
> > 1) !N_MEMORY -> N_MEMORY
> >     When the first memory block of a node transitions to the online state,
> >     it holds a non-negative value.
> >     In all other cases, it remains -1 (NUMA_NO_NODE).
> > 
> > 2) N_MEMORY -> !N_MEMORY
> >     When all memory blocks of a node transition to the offline state,
> >     it holds a non-negative value.
> >     In all other cases, it remains -1 (NUMA_NO_NODE).
> > 
> > I would truly appreciate it if you could confirm whether this analysis is correct.
> > Below is a more detailed explanation of my findings.
> > 
> 
> Yes, that's at least how it is supposed to work (-bugs, but I am not 
> aware of any) :)
> 

Thank you once again for reviewing this matter. Your insightful feedback has been
instrumental in crafting a more robust structure.

Rakie

> -- 
> Cheers,
> 
> David / dhildenb
> 
