Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7A61DFFC
	for <linux-cxl@vger.kernel.org>; Fri, 26 Apr 2024 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146963; cv=none; b=QPr1z3g2ySn5W2mI9LVuL9BFGoJxrrcrdmWcYSFGdenud3C3u5FW0rw0650xjS22VWeyoiGoeCAjnnREjA+z4j4zkLuV5tLwZwRhS8s+Q6DtHVpxJ/KWo8mA0XHzkdCZ6Fz+UTTyeTwF9Gq7VrVuERP1bnMjcgU8OuEl/mxdDOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146963; c=relaxed/simple;
	bh=yC3iAynJnIMKLymKn5BiGnSg11K/8GSUuUzJFwk9KVY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBuOkIhmNk+RL9zq4NIPjsNmFXZ7vE2XjGvg1D31/JSZED6nd8TK49yhKGAJ+2R/pWKvOWun3okd2YOMNe6cqFsXd0R5GwGuJYfZD78A7tIjKJJ3s52kMgX8qpnk5nyCGo9d2yGz2h+/dlSqfyHg6gHB75m0KmvduRvfqVsBPjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQy1l5zt0z6D8YK;
	Fri, 26 Apr 2024 23:53:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 59AD1140594;
	Fri, 26 Apr 2024 23:55:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Apr
 2024 16:55:56 +0100
Date: Fri, 26 Apr 2024 16:55:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Markus Armbruster <armbru@redhat.com>, <nifan.cxl@gmail.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<jim.harris@samsung.com>, <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan
 Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240426165555.0000181b@Huawei.com>
In-Reply-To: <6629426dcdbb3_e1bea294d8@iweiny-mobl.notmuch>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-10-nifan.cxl@gmail.com>
	<87a5livrdr.fsf@pond.sub.org>
	<6629426dcdbb3_e1bea294d8@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 24 Apr 2024 10:33:33 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> Markus Armbruster wrote:
> > nifan.cxl@gmail.com writes:
> >   
> > > From: Fan Ni <fan.ni@samsung.com>
> > >
> > > Since fabric manager emulation is not supported yet, the change implements
> > > the functions to add/release dynamic capacity extents as QMP interfaces.  
> > 
> > Will fabric manager emulation obsolete these commands?  
> 
> I don't think so.  In the development of the kernel, I see these being
> valuable to do CI and regression testing without the complexity of an FM.

Fully agree - I also long term see these as the drivers for one
possible virtualization stack for DCD devices (whether it turns
out to be the way forwards for that is going to take a while to
resolve!)

It doesn't make much sense to add a fabric manager into that flow
or to expose an appropriate (maybe MCTP) interface from QEMU just
to poke the emulated device.

Jonathan


> 
> Ira
> 
> >   
> > > Note: we skips any FM issued extent release request if the exact extent
> > > does not exist in the extent list of the device. We will loose the
> > > restriction later once we have partial release support in the kernel.
> > >
> > > 1. Add dynamic capacity extents:
> > >
> > > For example, the command to add two continuous extents (each 128MiB long)
> > > to region 0 (starting at DPA offset 0) looks like below:
> > >
> > > { "execute": "qmp_capabilities" }
> > >
> > > { "execute": "cxl-add-dynamic-capacity",
> > >   "arguments": {
> > >       "path": "/machine/peripheral/cxl-dcd0",
> > >       "region-id": 0,
> > >       "extents": [
> > >       {
> > >           "dpa": 0,
> > >           "len": 134217728
> > >       },
> > >       {
> > >           "dpa": 134217728,
> > >           "len": 134217728
> > >       }
> > >       ]
> > >   }
> > > }
> > >
> > > 2. Release dynamic capacity extents:
> > >
> > > For example, the command to release an extent of size 128MiB from region 0
> > > (DPA offset 128MiB) look like below:
> > >
> > > { "execute": "cxl-release-dynamic-capacity",
> > >   "arguments": {
> > >       "path": "/machine/peripheral/cxl-dcd0",
> > >       "region-id": 0,
> > >       "extents": [
> > >       {
> > >           "dpa": 134217728,
> > >           "len": 134217728
> > >       }
> > >       ]
> > >   }
> > > }
> > >
> > > Signed-off-by: Fan Ni <fan.ni@samsung.com>  
> > 
> > [...]
> >   
> > > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > > index 8cc4c72fa9..2645004666 100644
> > > --- a/qapi/cxl.json
> > > +++ b/qapi/cxl.json
> > > @@ -19,13 +19,16 @@
> > >  #
> > >  # @fatal: Fatal Event Log
> > >  #
> > > +# @dyncap: Dynamic Capacity Event Log
> > > +#
> > >  # Since: 8.1
> > >  ##
> > >  { 'enum': 'CxlEventLog',
> > >    'data': ['informational',
> > >             'warning',
> > >             'failure',
> > > -           'fatal']
> > > +           'fatal',
> > > +           'dyncap']  
> > 
> > We tend to avoid abbreviations in QMP identifiers: dynamic-capacity.
> >   
> > >   }
> > >  
> > >  ##
> > > @@ -361,3 +364,59 @@
> > >  ##
> > >  {'command': 'cxl-inject-correctable-error',
> > >   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> > > +
> > > +##
> > > +# @CXLDCExtentRecord:  
> > 
> > Such traffic jams of capital letters are hard to read.
> > 
> > What does DC mean?
> >   
> > > +#
> > > +# Record of a single extent to add/release
> > > +#
> > > +# @offset: offset to the start of the region where the extent to be operated  
> > 
> > Blank line here, please
> >   
> > > +# @len: length of the extent
> > > +#
> > > +# Since: 9.0
> > > +##
> > > +{ 'struct': 'CXLDCExtentRecord',
> > > +  'data': {
> > > +      'offset':'uint64',
> > > +      'len': 'uint64'
> > > +  }
> > > +}
> > > +
> > > +##
> > > +# @cxl-add-dynamic-capacity:
> > > +#
> > > +# Command to start add dynamic capacity extents flow. The device will  
> > 
> > I think we're missing an article here.  Is it "a flow" or "the flow"?
> >   
> > > +# have to acknowledged the acceptance of the extents before they are usable.  
> > 
> > to acknowledge
> > 
> > docs/devel/qapi-code-gen.rst:
> > 
> >     For legibility, wrap text paragraphs so every line is at most 70
> >     characters long.
> > 
> >     Separate sentences with two spaces.
> >   
> > > +#
> > > +# @path: CXL DCD canonical QOM path  
> > 
> > What is a CXL DCD?  Is it a device?
> > 
> > I'd prefer @qom-path, unless you can make a consistency argument for
> > @path.
> >   
> > > +# @region-id: id of the region where the extent to add  
> > 
> > What's a region, and how do they get their IDs?
> >   
> > > +# @extents: Extents to add  
> > 
> > Blank lines between argument descriptions, please.
> >   
> > > +#
> > > +# Since : 9.0  
> > 
> > 9.1
> >   
> > > +##
> > > +{ 'command': 'cxl-add-dynamic-capacity',
> > > +  'data': { 'path': 'str',
> > > +            'region-id': 'uint8',
> > > +            'extents': [ 'CXLDCExtentRecord' ]
> > > +           }
> > > +}
> > > +
> > > +##
> > > +# @cxl-release-dynamic-capacity:
> > > +#
> > > +# Command to start release dynamic capacity extents flow. The host will  
> > 
> > Article again.
> > 
> > The host?  In cxl-add-dynamic-capacity's doc comment, it's the device.
> >   
> > > +# need to respond to indicate that it has released the capacity before it
> > > +# is made unavailable for read and write and can be re-added.  
> > 
> > Is "and can be re-added" relevant here?
> >   
> > > +#
> > > +# @path: CXL DCD canonical QOM path
> > > +# @region-id: id of the region where the extent to release
> > > +# @extents: Extents to release
> > > +#
> > > +# Since : 9.0  
> > 
> > 9.1
> >   
> > > +##
> > > +{ 'command': 'cxl-release-dynamic-capacity',
> > > +  'data': { 'path': 'str',
> > > +            'region-id': 'uint8',
> > > +            'extents': [ 'CXLDCExtentRecord' ]
> > > +           }
> > > +}  
> >   
> 
> 

