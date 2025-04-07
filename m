Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692E022A808;
	Mon,  7 Apr 2025 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744019379; cv=none; b=t73PvAxTvYn0tyRJPebcwT+RTMFriqgAlQgiq8Cnqs5gN2lMNb2cGjce1GCTpqQOIfm/x5hFDzVKjgrPaAP0lrMPrZaSvajdnIxefVP1n+489fVj8JY5nEz0X3oaEZI9GnS6F3s0gKzoALdbyN3yeRJqAOOmiCmFhwzUMGGB6lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744019379; c=relaxed/simple;
	bh=3+tkarQJVToety44JIPavZJwIKFiLWUn0JrvQxS5utg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlUsFlTY6AqiffXvTXyIjP///tpMET9s/QvuniPf3ENTobUzBgK81mIt43O3c37FriTziZRVnGmVjImra4fHliVfjovt/S2lNDZdHFRbyQRYLTGmiYh9XhKC8xyHVO/iCHoyqXy2OwSLdxLcr6OBuwx9zzlq9PnT3/eyWLSDMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZWPXz3SPbz67lLG;
	Mon,  7 Apr 2025 17:48:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 701A71400DB;
	Mon,  7 Apr 2025 17:49:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 7 Apr
 2025 11:49:26 +0200
Date: Mon, 7 Apr 2025 10:49:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Rakie Kim <rakie.kim@sk.com>, <akpm@linux-foundation.org>,
	<gourry@gourry.net>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <joshua.hahnjy@gmail.com>,
	<ying.huang@linux.alibaba.com>, <david@redhat.com>, <osalvador@suse.de>,
	<kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>
Subject: Re: [PATCH v6 2/3] mm/mempolicy: Prepare weighted interleave sysfs
 for memory hotplug
Message-ID: <20250407104924.00001dbb@huawei.com>
In-Reply-To: <67f0157e498c9_464ec294df@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250404074623.1179-1-rakie.kim@sk.com>
	<20250404074623.1179-3-rakie.kim@sk.com>
	<20250404140559.00001112@huawei.com>
	<67f0157e498c9_464ec294df@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 4 Apr 2025 10:23:10 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Fri, 4 Apr 2025 16:46:20 +0900
> > Rakie Kim <rakie.kim@sk.com> wrote:
> >   
> > > Previously, the weighted interleave sysfs structure was statically
> > > managed during initialization. This prevented new nodes from being
> > > recognized when memory hotplug events occurred, limiting the ability
> > > to update or extend sysfs entries dynamically at runtime.
> > > 
> > > To address this, this patch refactors the sysfs infrastructure and
> > > encapsulates it within a new structure, `sysfs_wi_group`, which holds
> > > both the kobject and an array of node attribute pointers.
> > > 
> > > By allocating this group structure globally, the per-node sysfs
> > > attributes can be managed beyond initialization time, enabling
> > > external modules to insert or remove node entries in response to
> > > events such as memory hotplug or node online/offline transitions.
> > > 
> > > Instead of allocating all per-node sysfs attributes at once, the
> > > initialization path now uses the existing sysfs_wi_node_add() and
> > > sysfs_wi_node_delete() helpers. This refactoring makes it possible
> > > to modularly manage per-node sysfs entries and ensures the
> > > infrastructure is ready for runtime extension.
> > > 
> > > Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> > > Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> > > Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> > > Reviewed-by: Gregory Price <gourry@gourry.net>  
> > Hi Rakie,
> > 
> > Some things I was requesting in patch 1 are done here.
> > Mostly I think what is wanted is moving some of that
> > refactoring back to that patch rather than here.
> > 
> > Some of the label and function naming needs another look.
> > 
> > Jonathan  
> [..]
> > > @@ -3430,27 +3437,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
> > >  	return count;
> > >  }
> > >  
> > > -static struct iw_node_attr **node_attrs;
> > > -
> > > -static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
> > > -				  struct kobject *parent)
> > > +static void sysfs_wi_node_delete(int nid)  
> > 
> > Maybe stick to release naming to match the sysfs_wi_release()
> > below? I don't really care about this.  
> 
> I had asked for "delete" to pair with "add" and to not get confused with
> a final kobject_put() callback.
> 

Fair enough.
