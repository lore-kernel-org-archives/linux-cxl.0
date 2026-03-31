Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D5B258EC2
	for <linux-cxl@vger.kernel.org>; Tue, 31 Mar 2026 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968653; cv=none; b=jIPKXabCIdhn+ZJbgz9faOhsQGyDckJHtg+R1mwq4EgyZb2nASlVyn7NZjsSNHj4jdMnrmKO8+2XHnbKk0prkFKuFkZH5sPyJhL0ooXvLwAAzmusShf3PWSHM78hY+0UzCdXvLAsfQPwtv/Bkt7G1AXFjIa46H6VydixkdVEu4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968653; c=relaxed/simple;
	bh=Mmb7vr4BkrgY6dZNNYez9kA5KnQqUFF8KwAdDIb2NWI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUtb5JN5+O3IeSmk3Ym7b5GkRUj6pCSnkE7A+NtIzbsmr49reRy+Ta7uTYbVgSA7RBwWt1tt1uiHiWzt1ttY1AB3Htv+ogSJwrCSEAsbKyOXKcGwJ236dQuxROuOFq6+nHqRZlqMpe6DLir7oGsSSebA3ZRm9/qf5UVKAw7LfyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4flWJ76QhRzJ4681;
	Tue, 31 Mar 2026 22:50:31 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C61440575;
	Tue, 31 Mar 2026 22:50:50 +0800 (CST)
Received: from localhost (10.203.177.99) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 31 Mar
 2026 15:50:49 +0100
Date: Tue, 31 Mar 2026 15:50:44 +0100
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <anisa.su@samsung.com>, <berrange@redhat.com>,
	<eblake@redhat.com>, <jonathan.cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
	<mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
	<nifan.cxl@gmail.com>, <me@linux.beauty>, <ira.weiny@intel.com>
Subject: Re: [PATCH 9/9] hw/cxl: Add QMP status query for dynamic-capacity
 extent release
Message-ID: <20260331155044.0000603d.alireza.sanaee@huawei.com>
In-Reply-To: <87zf3s1ohc.fsf@pond.sub.org>
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
	<20260325184259.366-10-alireza.sanaee@huawei.com>
	<87mrzuei5f.fsf@pond.sub.org>
	<20260327151811.00005564.alireza.sanaee@huawei.com>
	<87zf3s1ohc.fsf@pond.sub.org>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sat, 28 Mar 2026 07:01:51 +0100
Markus Armbruster <armbru@redhat.com> wrote:

+CC Ira

Hi Markus,

Please look inline. I believe Ira might be able to help and we can see what he thinks.

> Alireza Sanaee <alireza.sanaee@huawei.com> writes:
> 
> > On Thu, 26 Mar 2026 16:15:40 +0100
> > Markus Armbruster <armbru@redhat.com> wrote:
> >
> > Hi Markus,
> >
> > This commit adds a test command to check whether an extent (a piece of memory region) has been released or not by the guest.
> > The process of removal is highly asynchronous, that's why I needed to add a new command to check it.
> >
> > I would be happy to drop this patch, as this is extra.  
> 
> So your motivation for adding the command is "just" testing.  Correct?

I wrote tests to make sure extents were released, and I used this QMP command to check.

Now there is background about extents where DCD was developed in Linux by @Ira, CCed [1].

In the DCD extent tracking section of the CXL spec, I see some commands 
related to getting the extent list, maybe Ira can comment here. To be fair, knowing if an extent
was released or not is a useful information in general from orchestrator perspective.

[1] https://patchew.org/linux/20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com/

> 
> Can you think of other uses?
> 
> In particular, would a management application need this query to monitor
> removal?

I think management will get a signal on the removal given the schema in Ira's Linux kernel 
patchset. I do not think this is implemented in QEMU at least (I might be missing something).

> 
> The description of feature @unstable may need to be adjusted for the
> answers we work out here.

Absolutely.

> 
> >
> > Thanks,
> > Ali  
> 
> 

