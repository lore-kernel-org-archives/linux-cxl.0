Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9DF320CCF
	for <linux-cxl@vger.kernel.org>; Tue, 23 Dec 2025 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766490812; cv=none; b=ssv5hH2qtGolejQNRkqQeYsz1jdeJ5s0gwxi4/TZkktbgQLTVIg/PpnLSHL6cef9E0ZYPLbiyMo74xZBuXc+OMpESeM2N8pMia02P42a/AEKmgcTuItHItVTOCfl0P2dsf1PMTiDrvjEYmG86IdoJPPdZdzrkmy2ZSg7RPBWOFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766490812; c=relaxed/simple;
	bh=kR3LYPAHY8SXMryqqdfGo+WgV8NVQlwHFfslieMSFrE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnCxOT3n0jwDcsS2ZX5YKyTghFdu8MgoHEcwSgwT9Y68pZu2ZZ2NMbjdEpQoCKoqIE+I+7hJCkxYdNlHN79d0pmjjxQs7SRoUsJf/mQEykVk0hSGwX0N3+rGSvOyAfW5bONUqjq0tszd6AUsLc8vfLE29H1q3yYpFhddrDJmDlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dbD0L6855zHnGj5;
	Tue, 23 Dec 2025 19:52:50 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id C1EFC40539;
	Tue, 23 Dec 2025 19:53:27 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 23 Dec
 2025 11:53:27 +0000
Date: Tue, 23 Dec 2025 11:53:25 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Jonathan Cameron via <qemu-devel@nongnu.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Davidlohr Bueso
	<dave@stgolabs.net>, <ira.weiny@intel.com>, <alucerop@amd.com>,
	<a.manzanares@samsung.com>, <dongjoo.seo1@samsung.com>, <mst@redhat.com>,
	<marcel.apfelbaum@gmail.com>, <armbru@redhat.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 -qemu 0/5] hw/cxl: Support Back-Invalidate
Message-ID: <20251223115325.00000a36@huawei.com>
In-Reply-To: <20251217135930.00004616@huawei.com>
References: <20251103195209.1319917-1-dave@stgolabs.net>
	<20251216011211.anwnw25ot6n3euhq@offworld>
	<20251217135930.00004616@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 17 Dec 2025 13:59:30 +0000
Jonathan Cameron via <qemu-devel@nongnu.org> wrote:

> On Mon, 15 Dec 2025 17:12:11 -0800
> Davidlohr Bueso <dave@stgolabs.net> wrote:
> 
> > ping? If there are no further issues, could this be picked up into
> > your jic23 tree?
> > 
> > Thanks,
> > Davidlohr
> >   
> Hi Davidlohr,
> 
> I'm just waiting on the 10.2 release before bringing my tree up to
> date and reposting the various series that I consider ready which
> didn't get merged in 10.2.
> 
> Then I'll figure out where in the tree to push these in.  I might
> do the leg work for that before the release, but given that should
> happen shortly I'll not push a tree out on gitlab until after that.
> 
> Jonathan
> 
Hi Davidlohr,

Seems the release has been tagged, so I've just rebased and pushed
out a draft tree as cxl-2025-12-23-draft
Draft because it is very very lightly tested so far.

On that I've merged in these patches with a few tweaks + added the
table test updates.  If you get a minute to take a look please do.

It's behind a couple of left over series from earlier cycles but my
intent is to post it for reviews prior to merge shortly.  That
may not include in the restrictions control qapi as I think that interface
may need more thought.  For now I've added a patch that just enables
BI always for CFMWSes.

Jonathan
 
