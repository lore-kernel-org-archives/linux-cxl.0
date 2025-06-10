Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA68D22129B
	for <linux-cxl@vger.kernel.org>; Tue, 10 Jun 2025 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547144; cv=none; b=CpLjv6HF7a15uRDJlkW6Oe3vWPbgWf62qTihkvZ0hTk/qAi+sk2Pv9fzxyqSy/vLLjNBjyvCZ3KlCJNbwuUYVVVJRLNDKX78KAu7yetNSpeEZkDEynbcVCuiNdJkfaROh5XRlIwZLwx7yTYOffM7Px6ptVMdrwYOzh6k2QvD/jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547144; c=relaxed/simple;
	bh=6omifvu5KSTxc3ipD7jDhPisHAB9LQNHFvwnv9fU1jw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aol5rvxcKE/eJxZFNaRwKO8c7DMlN1D/KVt1cMvAvcratgn8grN6RzYDK7BAP/uDM1yxAFCM1FEyUO9vogL/oXR4dY/sWYkwyvnbZycnrCfI+KO2cTd2pdN866GjzyNdp+g4OqOBZFii8t3xY+UMJmRAJcNQEjapT31K/xj4bYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGjmN3MVyz6H6q9;
	Tue, 10 Jun 2025 17:14:44 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2AE1D140275;
	Tue, 10 Jun 2025 17:18:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 10 Jun
 2025 11:18:58 +0200
Date: Tue, 10 Jun 2025 10:18:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
	<peter.maydell@linaro.org>, <mst@redhat.com>, <linuxarm@huawei.com>,
	<linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
	<philmd@linaro.org>, Alireza Sanaee <alireza.sanaee@huawei.com>
Subject: Re: [PATCH v14 2/5] hw/cxl: Make the CXL fixed memory windows
 devices.
Message-ID: <20250610101857.00002818@huawei.com>
In-Reply-To: <aEdl6xvqyOsU+Z2S@vm4>
References: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
	<20250528110726.226389-3-Jonathan.Cameron@huawei.com>
	<20250529160801.00003ade@huawei.com>
	<aEdl6xvqyOsU+Z2S@vm4>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 10 Jun 2025 07:53:31 +0900
Itaru Kitayama <itaru.kitayama@linux.dev> wrote:

> On Thu, May 29, 2025 at 04:08:01PM +0100, Jonathan Cameron wrote:
> > On Wed, 28 May 2025 12:07:23 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> > > Previously these somewhat device like structures were tracked using a list
> > > in the CXLState in each machine.  This is proving restrictive in a few
> > > cases where we need to iterate through these without being aware of the
> > > machine type. Just make them sysbus devices.
> > > 
> > > Restrict them to not user created as they need to be visible to early
> > > stages of machine init given effects on the memory map.
> > > 
> > > This change both simplifies state tracking and enables features needed
> > > for performance optimization and hotness tracking by making it possible
> > > to retrieve the fixed memory window on actions elsewhere in the topology.
> > > 
> > > In some cases the ordering of the Fixed Memory Windows matters.
> > > For those utility functions provide a GSList sorted by the window index.
> > > This ensures that we get consistency across:
> > > - ordering in the command line
> > > - ordering of the host PA ranges
> > > - ordering of ACPI CEDT structures describing the CFMWS.
> > > 
> > > Other aspects don't have this constraint. For those direct iteration
> > > of the underlying hash structures is fine.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > 
> > I'll not post v15 for a while to give time for review, but I just realized
> > this snippet was in a patch I was carrying on top of this and should have
> > been in this patch.
> > 
> > diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> > index a610795c87..de66ab8c35 100644
> > --- a/include/hw/cxl/cxl.h
> > +++ b/include/hw/cxl/cxl.h
> > @@ -46,7 +46,6 @@ typedef struct CXLState {
> >      bool is_enabled;
> >      MemoryRegion host_mr;
> >      unsigned int next_mr_idx;
> > -    GList *fixed_windows;
> >      CXLFixedMemoryWindowOptionsList *cfmw_list;
> >  } CXLState;  
> 
> With this one line removed on top of v14, today's Dave's cxl/next kernel makes
> cxl test suite ran through without a single failure.
> 
> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> 
> Jonathan, Zhi jian of Fujitsu gave you feedback on the QEMU core CXL emulation code, 
> are you still waiting on any other reviewers to take a look at the series v14 (or
> v14-ish)?
No - obviously extra review is always good but I wasn't waiting on any.
Just been distracted so not sent it out yet. Should get it out in next day or two.

Jonathan


> 
> Thanks,
> Itaru.

> 
> >   

