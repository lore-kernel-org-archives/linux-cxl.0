Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE0D393DD1
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327172; cv=none; b=QguZDqUqTV6deRSED5Y0CKzyog5vzJV1Xrbm+2yy12/wJx/OJ239+2JvdxkinhIyi2f6WEpJWovhsXC5Ge8mn16BmygOLV7crF32kgDWpzifb2wAmcPGPju5u6+qzoZ6xCVhNLMiRL41+T7/oSEXpq7pBnu6O4fXPWHHbnGwiD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327172; c=relaxed/simple;
	bh=ow8F/JpJXy2NNZUjXjej/bxbdm4Vn4HAjcxg8lToB2k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9q2pET7sx4kuMSJqR0OairVONHJtaNXGXEjrwDjFLUlpbOzQOjgwxRdwf39FyNb+wKnp7LZR1tYSjDOxmlvbwbeL6CVr2YVA0wsr8Y+eGH8JmNy+FgmqoXO2ELfjdsnMSnXurwTRJYd90XAumTYo1sN6kmKdfVyS2B3e/odcQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drH7P4wT9zJ467D;
	Wed, 14 Jan 2026 01:59:13 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 124CE40086;
	Wed, 14 Jan 2026 01:59:27 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 13 Jan
 2026 17:59:26 +0000
Date: Tue, 13 Jan 2026 17:59:25 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Markus Armbruster <armbru@redhat.com>
CC: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>,
	<shiju.jose@huawei.com>, <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	"Ravi Shankar" <venkataravis@micron.com>
Subject: Re: [PATCH qemu v2 5/5] hw/cxl/events: Updates for rev3.2 memory
 module event record
Message-ID: <20260113175925.00007966@huawei.com>
In-Reply-To: <87344bf29s.fsf@pond.sub.org>
References: <20260102151512.460766-1-Jonathan.Cameron@huawei.com>
	<20260102151512.460766-6-Jonathan.Cameron@huawei.com>
	<87344bf29s.fsf@pond.sub.org>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 12 Jan 2026 13:23:27 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > From: Shiju Jose <shiju.jose@huawei.com>
> >
> > CXL spec rev3.2 section 8.2.10.2.1.3 Table 8-50, memory module
> > event record has updated with following new fields.
> > 1. Validity Flags
> > 2. Component Identifier
> > 3. Device Event Sub-Type
> >
> > Add updates for the above spec changes in the CXL memory module
> > event reporting and QMP command to inject memory module event.
> >
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  qapi/cxl.json               | 12 +++++++++++-
> >  include/hw/cxl/cxl_events.h |  7 +++++--
> >  hw/mem/cxl_type3.c          | 20 ++++++++++++++++++++
> >  hw/mem/cxl_type3_stubs.c    |  4 ++++
> >  4 files changed, 40 insertions(+), 3 deletions(-)
> >
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index 3e4bad4ad0..752d46cda2 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -242,6 +242,14 @@
> >  # @corrected-persistent-error-count: Total number of correctable
> >  #     errors in persistent memory
> >  #
> > +# @component-id: Device specific component identifier for the event.
> > +#     May describe a field replaceable sub-component of the device.
> > +#
> > +# @is-comp-id-pldm: This flag specifies whether the device-specific
> > +#     component identifier format follows PLDM.
> > +#
> > +# @sub-type: Device event sub-type.
> > +#  
> 
> These three seem to be the same in CXLGeneralMediaEvent, CXLDRAMEvent,
> and CXLMemModuleEvent.  Should they live in their common base type
> CXLCommonEventBase?

We have documented that base as corresponding to the spec defined
Common event record header and these aren't part of that.  We could
invent a CXLMemCommonEventBase that contains the stuff that is shared
for memory types of errors but it would probably just confuse anyone
trying to correlate this stuff with the spec.

There are a lot more event records we don't yet support, or are not
directly injected because they are responses to some other action.
(e.g. dynamic capacity add produces an event but also changes a bunch
 of device state)

I'm not sure if we will add direct injection of any of those other
events in future. Some are errors such as MLD Port Event Records,
but reporting those inband makes no sense as normal PCIe error
reporting is used for that. They are to expose what happened to
an out of band monitoring interface (see examples in patch 2
discussion).

Thanks for all your other feedback. We'll resolve that for v3.

Jonathan

> 
> >  # Since: 8.1
> >  ##
> >  { 'struct': 'CXLMemModuleEvent',
> > @@ -251,7 +259,9 @@
> >              'life-used': 'uint8', 'temperature' : 'int16',
> >              'dirty-shutdown-count': 'uint32',
> >              'corrected-volatile-error-count': 'uint32',
> > -            'corrected-persistent-error-count': 'uint32'
> > +            'corrected-persistent-error-count': 'uint32',
> > +            '*component-id': 'str', '*is-comp-id-pldm':'bool',
> > +            'sub-type':'uint8'
> >              }}
> >  
> >  ##  
> 
> [...]
> 
> 
> 

