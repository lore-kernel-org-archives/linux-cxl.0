Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633C663B9
	for <linux-cxl@vger.kernel.org>; Thu,  4 Sep 2025 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975505; cv=none; b=tpLfb1j+kOVLIKlmGgcDR+kVc1cclsn588DYEqneKw/VoHNpfjfNzVP8yKUOpfL/109wGYCirJzZF9fBk8ggH/by0QT/jKTL7kZwypSTcUjgANVvkVMBDvV0Tg4ALiXJnH7gxMWNaLrppsOD2/I9Cff8fxxND3bYN7ZNrF7dddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975505; c=relaxed/simple;
	bh=I9Vdxv8LTqpV2w31VZasrBF10znKD7rqJbA5riCw0eg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqWSctHoBivgu60FwQqDwkrjO2//OPlqMTgc6RrwpLoja+IF8dx9hlti6M1l8hK/l8hXa6a8aS97zR/2EWQFbXn+Z0c2+eKXY6R/t45C6wUZKp2f3IoRC/ZWtZ0w8JPwCeQANAqYuqQU9FSDJX8/sDpyFxCYZqAf2ajMl40cRVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cHY1J54Xxz6GDP4;
	Thu,  4 Sep 2025 16:44:04 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id 19F0E1402EF;
	Thu,  4 Sep 2025 16:45:00 +0800 (CST)
Received: from localhost (10.203.177.99) by frapeml500003.china.huawei.com
 (7.182.85.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 4 Sep
 2025 10:44:59 +0200
Date: Thu, 4 Sep 2025 09:44:55 +0100
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
	<jonathan.cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<jim.harris@samsung.com>, <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>,
	<armbru@redhat.com>, <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>, Svetly
 Todorov <svetly.todorov@memverge.com>
Subject: Re: [PATCH v8 11/14] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20250904094455.0000194b.alireza.sanaee@huawei.com>
In-Reply-To: <68b71467b850a_4bae529418@iweiny-mobl.notmuch>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
	<20240523174651.1089554-12-nifan.cxl@gmail.com>
	<20250902113915.00001fbd.alireza.sanaee@huawei.com>
	<68b71467b850a_4bae529418@iweiny-mobl.notmuch>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500003.china.huawei.com (7.182.85.28)

On Tue, 2 Sep 2025 10:59:35 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> Alireza Sanaee wrote:
> > On Thu, 23 May 2024 10:44:51 -0700
> > nifan.cxl@gmail.com wrote:
> >   
> > > From: Fan Ni <fan.ni@samsung.com>
> > > 
> > > To simulate FM functionalities for initiating Dynamic Capacity Add
> > > (Opcode 5604h) and Dynamic Capacity Release (Opcode 5605h) as in
> > > CXL spec r3.1 7.6.7.6.5 and 7.6.7.6.6, we implemented two QMP
> > > interfaces to issue add/release dynamic capacity extents requests.
> > > 
> > > With the change, we allow to release an extent only when its DPA
> > > range is contained by a single accepted extent in the device.
> > > That is to say, extent superset release is not supported yet.
> > > 
> > > 1. Add dynamic capacity extents:
> > > 
> > > For example, the command to add two continuous extents (each
> > > 128MiB long) to region 0 (starting at DPA offset 0) looks like
> > > below:
> > > 
> > > { "execute": "qmp_capabilities" }
> > > 
> > > { "execute": "cxl-add-dynamic-capacity",
> > >   "arguments": {
> > >       "path": "/machine/peripheral/cxl-dcd0",
> > >       "host-id": 0,
> > >       "selection-policy": "prescriptive",
> > >       "region": 0,
> > >       "extents": [
> > >       {
> > >           "offset": 0,
> > >           "len": 134217728
> > >       },
> > >       {
> > >           "offset": 134217728,
> > >           "len": 134217728
> > >       }
> > >       ]
> > >   }
> > > }
> > > 
> > > 2. Release dynamic capacity extents:
> > > 
> > > For example, the command to release an extent of size 128MiB from
> > > region 0 (DPA offset 128MiB) looks like below:
> > > 
> > > { "execute": "cxl-release-dynamic-capacity",
> > >   "arguments": {
> > >       "path": "/machine/peripheral/cxl-dcd0",
> > >       "host-id": 0,
> > >       "removal-policy":"prescriptive",
> > >       "region": 0,
> > >       "extents": [
> > >       {
> > >           "offset": 134217728,
> > >           "len": 134217728
> > >       }
> > >       ]
> > >   }
> > > }
> > > 
> > > Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
> > > Reviewed-by: Gregory Price <gregory.price@memverge.com>
> > > Signed-off-by: Fan Ni <fan.ni@samsung.com>  
> 
> [snip]
> 
> > > +##
> > > +# @cxl-release-dynamic-capacity:
> > > +#
> > > +# Command to initiate to release dynamic capacity extents from a
> > > +# host.  It simulates operations defined in cxl spec r3.1
> > > 7.6.7.6.6. +#
> > > +# @path: CXL DCD canonical QOM path.
> > > +#
> > > +# @host-id: The "Host ID" field as defined in cxl spec r3.1
> > > +#     Table 7-71.
> > > +#
> > > +# @removal-policy: Bit[3:0] of the "Flags" field as defined in
> > > cxl +#     spec r3.1 Table 7-71.
> > > +#
> > > +# @forced-removal: Bit[4] of the "Flags" field in cxl spec r3.1
> > > +#     Table 7-71.  When set, device does not wait for a Release
> > > +#     Dynamic Capacity command from the host.  Host immediately
> > > +#     loses access to released capacity.
> > > +#
> > > +# @sanitize-on-release: Bit[5] of the "Flags" field in cxl spec
> > > r3.1 +#     Table 7-71.  When set, device should sanitize all
> > > released +#     capacity as a result of this request.
> > > +#
> > > +# @region: The "Region Number" field as defined in cxl spec r3.1
> > > +#     Table 7-71.  The dynamic capacity region where the capacity
> > > +#     is being added.  Valid range is from 0-7.
> > > +#
> > > +# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-71.
> > > +#
> > > +# @extents: The "Extent List" field as defined in cxl spec r3.1
> > > +#     Table 7-71.
> > > +#
> > > +# Since : 9.1
> > > +##
> > > +{ 'command': 'cxl-release-dynamic-capacity',
> > > +  'data': { 'path': 'str',
> > > +            'host-id': 'uint16',
> > > +            'removal-policy': 'CXLExtRemovalPolicy',
> > > +            '*forced-removal': 'bool',
> > > +            '*sanitize-on-release': 'bool',
> > > +            'region': 'uint8',
> > > +            '*tag': 'str',
> > > +            'extents': [ 'CXLDynamicCapacityExtent' ]
> > > +           }
> > > +}  
> > 
> > Although tag-based removal is not implemented yet, but still just
> > wanted to leave a comment here that exact extents are not needed
> > for tag-based removal and `extents` should be an optional parameter
> > here; this is my understanding reading the spec, so I still might
> > be wrong, shout if you think it does not make sense.  
> 
> It's been a while but I think this allows the removal of non-tagged
> extents as well(?)  If so the tag would be NULL (or empty-string) and
> one can remove a regular extent.
> 
> But I could be miss-remembering something,
> Ira
> 

Yes non-tagged is working completely.

