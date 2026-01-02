Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59592BD597
	for <linux-cxl@vger.kernel.org>; Fri,  2 Jan 2026 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767371727; cv=none; b=En3bFZMFIP9RbTHiF3kQUs5QO80imLTogr+A/CJwz7LqfZbcVnn57xPfnzNUbfG9U2wjXVjnvFlLKfC6nv86ROBHMmGsnY92vsneJ0bthLDEmBsLucMrvsb+oVydJwZgtMzFj/89WE70OQxDiRqiXoEDiy87tBtWPiwF0W3r8SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767371727; c=relaxed/simple;
	bh=k0J631j3cFA+6kWbYZAtvC2FCq7uXkRMQQ5N3txfl5Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJmqAF7afLsh2qzBWrpjQnGYvKFfzSl/2vbAJaNcgYLXS+rlBe6L3QQMLSLN6k1lAkYcaVxA8jhKBA0TNQVbBJXua1wCzcXEsnru1KtkViMRVCjVfObxEkKgtWBeLzDzZOOKEQYCQGOSrWxEhYk43W4zo7eCbSo3g362zR2IEcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djTmf2TRdzJ467L;
	Sat,  3 Jan 2026 00:34:26 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1430540086;
	Sat,  3 Jan 2026 00:35:22 +0800 (CST)
Received: from localhost (10.122.19.247) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 2 Jan
 2026 16:35:21 +0000
Date: Fri, 2 Jan 2026 16:35:19 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: Jonathan Cameron via <qemu-devel@nongnu.org>, <ira.weiny@intel.com>,
	<alucerop@amd.com>, <a.manzanares@samsung.com>, <dongjoo.seo1@samsung.com>,
	<mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <armbru@redhat.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 -qemu 0/5] hw/cxl: Support Back-Invalidate
Message-ID: <20260102163519.00005de4@huawei.com>
In-Reply-To: <20251230182330.upui2kkymnlylkh2@offworld>
References: <20251103195209.1319917-1-dave@stgolabs.net>
	<20251216011211.anwnw25ot6n3euhq@offworld>
	<20251217135930.00004616@huawei.com>
	<20251223115325.00000a36@huawei.com>
	<20251230182330.upui2kkymnlylkh2@offworld>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 30 Dec 2025 10:23:30 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Tue, 23 Dec 2025, Jonathan Cameron wrote:
> 
> >On Wed, 17 Dec 2025 13:59:30 +0000
> >Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> >
> >Seems the release has been tagged, so I've just rebased and pushed
> >out a draft tree as cxl-2025-12-23-draft
> >Draft because it is very very lightly tested so far.  
> 
> Thank you for picking this up, 'draft' is fine with me :)
> However, I am not seeing this new branch in your tree(?)

Hi Davidlohr,

Happy new year.

Hmm. Could have sworn I pushed i out... Guess messed that up :(

Note there is a stray change in there for an unrelated tests
tree that I've tidied up in my local tree.

I'll push a new tree out next week but assuming this series
isn't otherwise messed up by me, I'd like to email this out as
something I think is ready to merge before I do that. 

If you spot anything bad with this I might shuffle things around
to put the physical port commands set ahead of it.

Jonathan



> 
> >
> >On that I've merged in these patches with a few tweaks + added the
> >table test updates.  If you get a minute to take a look please do.
> >
> >It's behind a couple of left over series from earlier cycles but my
> >intent is to post it for reviews prior to merge shortly.  That
> >may not include in the restrictions control qapi as I think that interface
> >may need more thought.  For now I've added a patch that just enables
> >BI always for CFMWSes.  
> 
> Makes sense.
> 
> Thanks,
> Davidlohr
> 

