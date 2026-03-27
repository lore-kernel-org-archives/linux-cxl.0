Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E236842A80
	for <linux-cxl@vger.kernel.org>; Fri, 27 Mar 2026 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774624709; cv=none; b=fgM+DLpawc4yZWkwnxrrZp3mw1JLnEuy038PXzpohazO83ZY6HzZMGqfr+PSSCBM9t23z8P129kzyYvMWiMU2cfSphfgVnR9nG/T9VrgTSeTFI6Kl9IqGdl7tGxYdJZc283wlF9EF7MutsXWht5XpsnQBOlEy2W6IGr8DTSMTsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774624709; c=relaxed/simple;
	bh=lMHOwVjXWi8E80e8fHlqNr+wX9en/ytbJ8Nc2KHyGLY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmEohhDXNGpU6elErvhrM2ED5nbtmuap4FDTNUKin8FoyBxmAu2VIC5ANVoFt/TDBHcP7VXZveHt86soolOouv1EBSfj3LYiHtRZAgbiuhYQfvkG8VO8kaTqvIg15XvLNxPx6Nhaq9HqRcOeseX5BOeQ39CY/IFfqDZf+Wi6Opw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fj45p1HzJzJ46Bp;
	Fri, 27 Mar 2026 23:18:06 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 30FA640577;
	Fri, 27 Mar 2026 23:18:18 +0800 (CST)
Received: from localhost (10.203.177.99) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Mar
 2026 15:18:17 +0000
Date: Fri, 27 Mar 2026 15:18:11 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <anisa.su@samsung.com>, <berrange@redhat.com>,
	<eblake@redhat.com>, <jonathan.cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
	<mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
	<nifan.cxl@gmail.com>, <me@linux.beauty>
Subject: Re: [PATCH 9/9] hw/cxl: Add QMP status query for dynamic-capacity
 extent release
Message-ID: <20260327151811.00005564.alireza.sanaee@huawei.com>
In-Reply-To: <87mrzuei5f.fsf@pond.sub.org>
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
	<20260325184259.366-10-alireza.sanaee@huawei.com>
	<87mrzuei5f.fsf@pond.sub.org>
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
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 26 Mar 2026 16:15:40 +0100
Markus Armbruster <armbru@redhat.com> wrote:

Hi Markus,

This commit adds a test command to check whether an extent (a piece of memory region) has been released or not by the guest.
The process of removal is highly asynchronous, that's why I needed to add a new command to check it.

I would be happy to drop this patch, as this is extra.

Thanks,
Ali

> I'm a near-complete CXL ignoramus, and beg your patience.
> 
> Alireza Sanaee <alireza.sanaee@huawei.com> writes:
> 
> > Add a small status query so orchestration layers can check whether a tagged
> > extent is still pending, committed, or no longer present after a release
> > request.  
> 
> Why would they want to check?
> 
> What is a "release request"?
> 
> >
> > Introduce the ExtentStatus QAPI struct and the
> > cxl-release-dynamic-capacity-status command.
> >
> > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>  
> 
> [...]
> 
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index 81d6198ba0..53325ba530 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -636,3 +636,49 @@
> >             },
> >    'features': [ 'unstable' ]
> >  }
> > +
> > +##
> > +# @ExtentStatus:  
> 
> Blank line here, please.
> 
> > +# This is an object that describes the status of an extent.
> > +#
> > +# @status:   String indicating the overall result, e.g. "success".  
> 
> What are the possible values?  Are they defined in some spec?
> 
> > +# @message:  Human-readable description of the outcome.  
> 
> Intended use?
> 
> > +#
> > +# Since: 9.1  
> 
> 11.1 most likely.
> 
> > +##
> > +{ 'struct': 'ExtentStatus',
> > +      'data': { 'status': 'str', 'message': 'str' }
> > +}
> > +
> > +##
> > +# @cxl-release-dynamic-capacity-status:
> > +#
> > +# This commands checks if an extent tag has been released or not.  
> 
> Use imperative mood to describe commands: "Check whether an extent tag
> has been released."
> 
> > +#
> > +# @path: path to the CXL Dynamic Capacity Device in the QOM tree.  
> 
> We commonly call such members @qom-path.
> 
> > +#
> > +# @host-id: The "Host ID" field as defined in Compute Express Link
> > +#     (CXL) Specification, Revision 3.1, Table 7-71.
> > +#
> > +# @region: The "Region Number" field as defined in Compute Express
> > +#     Link Specification, Revision 3.1, Table 7-71.  Valid range
> > +#     is from 0-7.
> > +#
> > +# @tag: The "Tag" field as defined in Compute Express Link (CXL)
> > +#     Specification, Revision 3.1, Table 7-71.  
> 
> I guess the command interrogates something called "extent", and the
> something is related to the CXL device at @path in the QOM tree.
> Correct?
> 
> How is it related?  Is it a part of the device?
> 
> I further guess multiple extends can be so related, and @host-id,
> @region, and @tag identify select the one we want to interrogate.
> Correct?
> 
> > +#
> > +# Features:
> > +#
> > +# @unstable: For now this command is subject to change.  
> 
> The conventional language is "This command is experimental."
> 
> > +#
> > +# Since: 9.1  
> 
> 11.1 most likely.
> 
> > +##
> > +{ 'command': 'cxl-release-dynamic-capacity-status',
> > +  'data': { 'path': 'str',
> > +            'host-id': 'uint16',
> > +            'region': 'uint8',
> > +            'tag': 'str'
> > +          },
> > +  'features': [ 'unstable' ],
> > +  'returns': 'ExtentStatus'  
> 
> Swap these two lines, please.
> 
> > +}  
> 
> 

