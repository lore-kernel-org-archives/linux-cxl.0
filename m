Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2852E3363;
	Fri, 14 Mar 2025 06:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932068; cv=none; b=fWVAV39asqNoV/6cJkFY2814VWoe27OJ0Z+fPXcqaS4iXaVKx8RtNUc59YH93vYm51b8KfB+iHTuTy8uJmy+lVHFAxASEACo/WyQM+9WdaLO2VLcTiw9kM5Cf2vSI5nhFXFHACg8+pkMW3BlldqHOXFRUnSnXYHylpYeGfNVH8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932068; c=relaxed/simple;
	bh=p+jj2rRYNfCf6vPrlvYROsT9imZ6sghTkLF4L48tBSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvbKMAo8h/90SwJn7s++faIuS9jlk3OE2KAA8LebqqFI73I/UW1ra6SMy/zgBR1nrw2BCdgsydjrkl9JKaCV0CwlyROEvXz5NnW1L+ZVQZ+Nu8HDFFoghoPTPqpu7I+H+woAnsCFTnz0eUvLI7fFRT8f+7S4WSxt3yaSiCf0b0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-0a-67d3c61a2f75
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
Date: Fri, 14 Mar 2025 15:00:45 +0900
Message-ID: <20250314060053.743-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <713b6924-a653-453e-8fde-8c966638386b@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXC9ZZnka70scvpBleXs1jMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvF8a3z2C3OzzrFYnF51xw2i3tr/rNarF6T4cDpsXPWXXaP7rbL7B6L97xk
	8tj0aRK7x4kZv1k8dj609Hi/7yqbx+dNcgEcUVw2Kak5mWWpRfp2CVwZ75s6mAvajCu6W84z
	NTBuVe9i5OSQEDCRmLN+DhuM/bblE2sXIwcHm4CSxLG9MSBhEQENiU1tG5i7GLk4mAWuMEm0
	XAVxODiEBcIljr+tAjFZBFQlXq4XACnnFTCW2PfyBivERE2Jhkv3mEBsTgE7if8b9jCD2EIC
	PBKvNuxnhKgXlDg58wkLiM0sIC/RvHU22CoJgftsEvs6OlkgBklKHFxxg2UCI/8sJD2zkPQs
	YGRaxSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREY2Mtq/0TvYPx0IfgQowAHoxIP74Zdl9KFWBPL
	iitzDzFKcDArifCutr2QLsSbklhZlVqUH19UmpNafIhRmoNFSZzX6Ft5ipBAemJJanZqakFq
	EUyWiYNTqoHRK3KhVvYl96+cbXt40vb8/nrqx+MNd622OLkvXL7+6uP4Or2jXvyeUdtyqzpX
	VKyRuXLOselJ78oC2xQry5dFF8/uePh+l58ry8r1TrMifj95tsh6QTnD6ybV3Ws/PPL0DhSN
	FM9Q5m1YXBRkqtkVXeIfla72wMtf56qG19vMaYmKJUUBM72UWIozEg21mIuKEwExiI3EaAIA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsXCNUNNS1fq2OV0g65/5hZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZovjW+exWxyee5LV4vysUywWl3fNYbO4t+Y/q8Wha89ZLVavybD4
	vW0FmwOvx85Zd9k9utsus3ss3vOSyWPTp0nsHidm/Gbx2PnQ0uP9vqtsHt9ue3gsfvGByePz
	JrkArigum5TUnMyy1CJ9uwSujPdNHcwFbcYV3S3nmRoYt6p3MXJySAiYSLxt+cTaxcjBwSag
	JHFsbwxIWERAQ2JT2wbmLkYuDmaBK0wSLVdBHA4OYYFwieNvq0BMFgFViZfrBUDKeQWMJfa9
	vMEKMVFTouHSPSYQm1PATuL/hj3MILaQAI/Eqw37GSHqBSVOznzCAmIzC8hLNG+dzTyBkWcW
	ktQsJKkFjEyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAoN5We2fiTsYv1x2P8QowMGoxMO7
	YdeldCHWxLLiytxDjBIczEoivKttL6QL8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhP
	LEnNTk0tSC2CyTJxcEo1MGYn1V3fpTD5BHdYVpvJvWddWzr6n/FbRQv+077GZlka2ecqzti3
	/9F2w5TbU6tXT92U+Lj5xusp3+dFrW+Vedz+7EieSO6M22ccct9OPaO5TXnBTL5VfBv7JzT3
	5q+efFM4vnbXDtOfa2/s7Dh/cJ4Oe9QFmQQnx+/VOwojqqO9GU5NM1yyrVKJpTgj0VCLuag4
	EQCQXnLiYgIAAA==
X-CFilter-Loop: Reflected

On Thu, 13 Mar 2025 23:36:47 +0100 David Hildenbrand <david@redhat.com> wrote:
> On 13.03.25 17:23, Gregory Price wrote:
> > On Thu, Mar 13, 2025 at 03:33:37PM +0900, Rakie Kim wrote:
> >>> I'm fairly certain this logic is wrong.  If I add two memory blocks and
> >>> then remove one, would this logic not remove the sysfs entries despite
> >>> there being a block remaining?
> >>
> >> Regarding the assumption about node configuration:
> >> Are you assuming that a node has two memory blocks and that
> >> MEM_OFFLINE is triggered when one of them is offlined? If so, then
> >> you are correct that this logic would need modification.
> >>
> >> I performed a simple test by offlining a single memory block:
> >> # echo 0 > /sys/devices/system/node/node2/memory100/online
> >>
> >> In this case, MEM_OFFLINE was not triggered. However, I need to
> >> conduct further analysis to confirm this behavior under different
> >> conditions. I will review this in more detail and share my
> >> findings, including the test methodology and results.
> >>
> > 
> > +David - might have a quick answer to this.  I would have expected a
> > single memory block going offline to cause a notification.
> 
> Yes. Unless offlining failed, or the block was already offline :)
> 
> If it doesn't happen for an actual online memory block that is offline 
> after the call, we would have a bug.
> 
> 
> -- 
> Cheers,
> 
> David / dhildenb
>

Hi David,

I am currently working on adding memory hotplug-related functionality
to the weighted interleave feature. While discussing this with Gregory,
a question came up. If you happen to know the answer to the following,
I would greatly appreciate your input.

I have added the following logic to call add_weight_node when a node
transitions to the N_MEMORY state to create a sysfs entry. Conversely,
when all memory blocks of a node go offline (!N_MEMORY),
I call sysfs_wi_node_release to remove the corresponding sysfs entry.

+static int wi_node_notifier(struct notifier_block *nb,
+                              unsigned long action, void *data)
+{
+       int err;
+       struct memory_notify *arg = data;
+       int nid = arg->status_change_nid;
+
+       if (nid < 0)
+               goto notifier_end;
+
+       switch(action) {
+       case MEM_ONLINE:
+               err = add_weight_node(nid, wi_kobj);
+               if (err) {
+                       pr_err("failed to add sysfs [node%d]\n", nid);
+                       kobject_put(wi_kobj);
+                       return NOTIFY_BAD;
+               }
+               break;
+       case MEM_OFFLINE:
+               sysfs_wi_node_release(node_attrs[nid], wi_kobj);
+               break;
+       }
+
+notifier_end:
+       return NOTIFY_OK;
+}

One question I have is whether the MEM_OFFLINE action in the code
below will be triggered when a node that consists of multiple memory
blocks has only one of its memory blocks transitioning to the offline state.

+       int nid = arg->status_change_nid;
+
+       if (nid < 0)
+               goto notifier_end;

Based on my analysis, wi_node_notifier should function as expected
because arg->status_change_nid only holds a non-negative value
under the following conditions:

1) !N_MEMORY -> N_MEMORY
   When the first memory block of a node transitions to the online state,
   it holds a non-negative value.
   In all other cases, it remains -1 (NUMA_NO_NODE).

2) N_MEMORY -> !N_MEMORY
   When all memory blocks of a node transition to the offline state,
   it holds a non-negative value.
   In all other cases, it remains -1 (NUMA_NO_NODE).

I would truly appreciate it if you could confirm whether this analysis is correct.
Below is a more detailed explanation of my findings.

<memory block online>
- The callback function registered in hotplug_memory_notifier
  receives the MEM_ONLINE action in online_pages.
int online_pages(unsigned long pfn, unsigned long nr_pages,
		       struct zone *zone, struct memory_group *group)
{
	struct memory_notify arg;
...
	node_states_check_changes_online(nr_pages, zone, &arg);
	ret = memory_notify(MEM_GOING_ONLINE, &arg);
...
	node_states_set_node(nid, &arg);
...
	memory_notify(MEM_ONLINE, &arg);
}

- If the node is in the !N_MEMORY state,
  arg->status_change_nid is set to the node ID.
static void node_states_check_changes_online(unsigned long nr_pages,
	struct zone *zone, struct memory_notify *arg)
{
	int nid = zone_to_nid(zone);

	arg->status_change_nid = NUMA_NO_NODE;
	arg->status_change_nid_normal = NUMA_NO_NODE;

	if (!node_state(nid, N_MEMORY))
		arg->status_change_nid = nid;
...
}
- If arg->status_change_nid >= 0, the node transitions to the N_MEMORY state.
static void node_states_set_node(int node, struct memory_notify *arg)
{
...
	if (arg->status_change_nid >= 0)
		node_set_state(node, N_MEMORY);
}


<memory block offline>
- The callback function registered in hotplug_memory_notifier
  receives the MEM_OFFLINE action in offline_pages.
int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
			struct zone *zone, struct memory_group *group)
{
	struct memory_notify arg;
...
	node_states_check_changes_offline(nr_pages, zone, &arg);
	ret = memory_notify(MEM_GOING_OFFLINE, &arg);
...
	node_states_clear_node(node, &arg);
...
	memory_notify(MEM_OFFLINE, &arg);
}

- If the node becomes empty,
  arg->status_change_nid is set to the node ID.
static void node_states_check_changes_offline(unsigned long nr_pages,
		struct zone *zone, struct memory_notify *arg)
{
...
	/*
	 * We have accounted the pages from [0..ZONE_NORMAL); ZONE_HIGHMEM
	 * does not apply as we don't support 32bit.
	 * Here we count the possible pages from ZONE_MOVABLE.
	 * If after having accounted all the pages, we see that the nr_pages
	 * to be offlined is over or equal to the accounted pages,
	 * we know that the node will become empty, and so, we can clear
	 * it for N_MEMORY as well.
	 */
	present_pages += pgdat->node_zones[ZONE_MOVABLE].present_pages;

	if (nr_pages >= present_pages)
		arg->status_change_nid = zone_to_nid(zone);
}

- If arg->status_change_nid >= 0,
  the node transitions to the !N_MEMORY state.
static void node_states_clear_node(int node, struct memory_notify *arg)
{
...
	if (arg->status_change_nid >= 0)
		node_clear_state(node, N_MEMORY);
}

Thank you very much for taking the time to read this lengthy email.

Rakie
