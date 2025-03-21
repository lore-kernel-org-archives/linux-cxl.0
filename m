Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F0F78F5B;
	Fri, 21 Mar 2025 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742531859; cv=none; b=Ifn/cpsZIvOztGXqKizh8rTYUeWOVKTbjysuAkFNF9WRrshEloZQA3+SZEz9NsgEdifFrK8z424OnsJb3UF8XoXVtrzBLyLuBl3Eh9Diq+aKbENmcW2IliIgGqamURgag8JUnXp+IbtT0A/KEfRiHPn8hpWM0tWIGgr7SvNzEag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742531859; c=relaxed/simple;
	bh=Ttn7QI1o8IyeW1U3xYwLihbeTzpe2CuqBilEoSb9Ap0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxUHcQP50g0VTJr6tpu/6R2j2sSIPfG8vYrKWQ9u3aHdJxnfFDWxZCW1nvRwoJC9GgV/KtTDXwucGL8vVX3ayhuzzn7zqTjsOXcFzi21YAzM8nz49tGWeSBB3CBmENMVWRb+Q29wZuvi16JbHEHJNGiAwX9HglAzxy5J6A94SgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-08-67dced0dd0e6
From: Rakie Kim <rakie.kim@sk.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: gourry@gourry.net,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH v3 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
Date: Fri, 21 Mar 2025 13:37:22 +0900
Message-ID: <20250321043729.939-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250320164532.1313581-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsXC9ZZnoS7v2zvpBg3zVS3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2qxek2GA5fHzll32T262y6z
	e7QcecvqsXjPSyaPTZ8msXucmPGbxWPnQ0uP9/uusnl83iQXwBnFZZOSmpNZllqkb5fAlbFz
	52TGgk6jilu3G5kaGA+odzFyckgImEicPPGdCcZ+P3sNexcjBwebgJLEsb0xIGERAU2JE62T
	mLsYuTiYBe4wSTw/eJcNpEZYIFyidYYoSA2LgKpE96clzCA2r4CxxOEHN6FGako0XLoHZnMK
	2Es8PfOVDcQWEuCReLVhPyNEvaDEyZlPWEBsZgF5ieats8F2SQi8ZpNY3H8RapCkxMEVN1gm
	MPLPQtIzC0nPAkamVYxCmXlluYmZOSZ6GZV5mRV6yfm5mxiB4b6s9k/0DsZPF4IPMQpwMCrx
	8Fr8uZ0uxJpYVlyZe4hRgoNZSYRXpAMoxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6
	YklqdmpqQWoRTJaJg1OqgTGkQWB2uEZi9FLujs4fetzZCa99OLWfrJrwy+H77fvnv82yUdl3
	LGHNGYPzml+vB6/IOBKnrbA2WkjxYN+RotcuakrzM7IFF/w7cMpd/tCGrP+L9rj75VdP3ZOb
	HPtVflqR58nDEzt4PHhnffl6wVt0wdyjfVeFtHhP3qtSDWaRXHP28b31cZVKLMUZiYZazEXF
	iQDys0hvcwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsXCNUNNS5f37Z10g51bxSzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWhy69pzV
	YvWaDIvf21awOfB57Jx1l92ju+0yu0fLkbesHov3vGTy2PRpErvHiRm/WTx2PrT0eL/vKpvH
	t9seHotffGDy+LxJLoA7issmJTUnsyy1SN8ugStj587JjAWdRhW3bjcyNTAeUO9i5OSQEDCR
	eD97DXsXIwcHm4CSxLG9MSBhEQFNiROtk5i7GLk4mAXuMEk8P3iXDaRGWCBconWGKEgNi4Cq
	RPenJcwgNq+AscThBzeZIEZqSjRcugdmcwrYSzw985UNxBYS4JF4tWE/I0S9oMTJmU9YQGxm
	AXmJ5q2zmScw8sxCkpqFJLWAkWkVo0hmXlluYmaOqV5xdkZlXmaFXnJ+7iZGYIgvq/0zcQfj
	l8vuhxgFOBiVeHgt/txOF2JNLCuuzD3EKMHBrCTCK9IBFOJNSaysSi3Kjy8qzUktPsQozcGi
	JM7rFZ6aICSQnliSmp2aWpBaBJNl4uCUamBkyPlcf0Lk/wbf1jmi/1YsZM+36Mn5t31SgNbG
	L7Fn2H/fOGqfk7UuaEKFba8YR4Logj23813ev7E1mLJ9zp3n9TclA3N5p7OJCz302NDKcXnr
	oeM1L5eskml65Fe29gTX2sdfJD41+F/pf1UfrL1Kc8EKR8WSH7ZZ3cI8Jz2cXvl+uWH1Pd5R
	iaU4I9FQi7moOBEAVn9MaG0CAAA=
X-CFilter-Loop: Reflected

On Thu, 20 Mar 2025 09:45:31 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

Hi Joshua
Thank you for your response regarding this patch.

> Hi Rakie, thank you for the new version! I have just a few questions / nits
> about this patch.
> 
> On Thu, 20 Mar 2025 13:17:46 +0900 Rakie Kim <rakie.kim@sk.com> wrote:
> 
> > Memory leaks occurred when removing sysfs attributes for weighted
> > interleave. Improper kobject deallocation led to unreleased memory
> > when initialization failed or when nodes were removed.
> > 
> > This patch resolves the issue by replacing unnecessary `kfree()`
> > calls with `kobject_put()`, ensuring proper cleanup and preventing
> > memory leaks.
> > 
> > By correctly using `kobject_put()`, the release function now
> > properly deallocates memory without causing resource leaks,
> > thereby improving system stability.
> > 
> > Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
> > Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> > ---
> >  mm/mempolicy.c | 61 +++++++++++++++++++++++++-------------------------
> >  1 file changed, 31 insertions(+), 30 deletions(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index bbaadbeeb291..5950d5d5b85e 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -3448,7 +3448,9 @@ static void sysfs_wi_release(struct kobject *wi_kobj)
> >  
> >  	for (i = 0; i < nr_node_ids; i++)
> >  		sysfs_wi_node_release(node_attrs[i], wi_kobj);
> > -	kobject_put(wi_kobj);
> > +
> > +	kfree(node_attrs);
> > +	kfree(wi_kobj);
> >  }
> 
> I think the intent here is to make mempolicy_sysfs_init call kobject_put, which
> will then call sysfs_wi_release when the refcount is 0. So I think replacing
> kobject_put with kfree makes a lot of sense here. However, I think it is a bit
> confusing based on the commit message, which states that you are doing the
> opposite (replacing kfree with kobject_put). Perhaps it makes more sense to
> say that you are moving kfree() from sysfs_init to the release function, so
> that the struct and the node_attrs struct is freed together by the last
> reference holder.

Yes, this patch does both: it replaces kfree with kobject_put and, as you 
also mentioned, it moves the actual kfree logic into the release function.
I agree the original explanation may have been unclear, so I will review
and revise the commit message accordingly.

> 
> >  static const struct kobj_type wi_ktype = {
> > @@ -3494,15 +3496,22 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
> >  	struct kobject *wi_kobj;
> >  	int nid, err;
> >  
> > -	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> > -	if (!wi_kobj)
> > +	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> > +			     GFP_KERNEL);
> > +	if (!node_attrs)
> >  		return -ENOMEM;
> 
> It's also not obvious to me why the allocation for node_attrs was moved to
> add_weighted_interleave_group. Maybe this refactoring belongs in patch 2,
> whose described intent is to consolidate the two objects into one (I expand
> on this idea below)

The reason for moving node_attrs is that it should be tied to wi_kobj
rather than mempolicy_kobj. Since node_attrs must be freed together
with wi_kobj, the allocation was relocated. I believe this behavior
is more clearly expressed in Patch 2.

> 
> > +	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> > +	if (!wi_kobj) {
> > +		err = -ENOMEM;
> > +		goto node_out;
> > +	}
> > +
> >  	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
> >  				   "weighted_interleave");
> >  	if (err) {
> > -		kfree(wi_kobj);
> > -		return err;
> > +		kobject_put(wi_kobj);
> > +		goto err_out;
> >  	}
> >  
> >  	for_each_node_state(nid, N_POSSIBLE) {
> > @@ -3512,9 +3521,17 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
> >  			break;
> >  		}
> >  	}
> > -	if (err)
> > +	if (err) {
> >  		kobject_put(wi_kobj);
> > +		goto err_out;
> > +	}
> > +
> >  	return 0;
> > +
> > +node_out:
> > +	kfree(node_attrs);
> > +err_out:
> 
> NIT: Is there a reason why we have a single line goto statement? Maybe it
> is more readable to replace all `goto err_out` with `return err` and save
> a few jumps : -)

This is also being cleaned up in Patch 2. In fact, once Patch 2 is
applied, the node_out label becomes unnecessary.

> 
> > +	return err;
> >  }
> >  
> >  static void mempolicy_kobj_release(struct kobject *kobj)
> > @@ -3528,7 +3545,6 @@ static void mempolicy_kobj_release(struct kobject *kobj)
> >  	mutex_unlock(&iw_table_lock);
> >  	synchronize_rcu();
> >  	kfree(old);
> > -	kfree(node_attrs);
> 
> I think the intent of this patch is slightly confusing. Viewing this patch
> alone, it is not entirely obvious why the kfree for node_attrs is now being
> moved from the release of mempolicy_kobj to wi_kobj. Of course, we know that
> it is actually because this patch serves a secondary purpose of moving
> the allocations / freeing of nattrs and wi_kobj together, so that in the
> next patch they can be combined into a single struct.
> 
> I think one way to make this patch more readable and maintainable is to
> separate it into (1) fixes, (as the Fixes: tag in your commit message suggests)
> and (2) refactoring that prepares for the next patch.
> 
> Please let me know what you think -- these were just some thoughts that I had
> while I was reading the patch. Thank you again for this new version!
> 
> Have a great day : -)
> Joshua

As you mentioned, I agree that Patch 1 may be a bit unclear.
In fact, Patch 1 and Patch 2 share similar goals, and in my view,
they only provide complete functionality when applied together.

Initially, I thought that Patch 1 was the fix for the original issue and
considered it the candidate for a backport.
However, upon further reflection, I believe that all changes in Patch 1
through Patch 3 are necessary to fully address the underlying problem.

Therefore, I now think it makes more sense to merge Patch 1 and Patch 2
into a single patch, then renumber the current Patch 3 as Patch 2,
and treat the entire set as a proper -stable backport candidate.

I'd appreciate your thoughts on this suggestion.

Rakie

> 
> Sent using hkml (https://github.com/sjp38/hackermail)
> 
