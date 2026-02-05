Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E1526E719
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770279382; cv=none; b=VI7cWdAH2ikBgnNleNsjqAWKZu55/K6QbvAL47wYjT4jSdcBQ2LFBf3mKbqDQDCKD/0BOMGX0ExO0IkBuw+VcXxtSzrG5ymY5hyjtjrSKw3ti5vQnninI8Q9Gh/fM3FiocUZLMkqymgHLBxbl/eN4pB4d0ItHVqbnzkF5BmA59g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770279382; c=relaxed/simple;
	bh=1pp0CcwU22cx8MpslQzZix+axBQ3KdmK/DEI8TKS2bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bmn8RNxKPLfTjgLH32MATqgpIOZuqsktPh2wCNLHkfATg8CxKzFKv+Va6AbuzNFyXM+e9e9QsGUosPyNpcxKfv71y1gJXSj17uPDTFUmRRQkxIFB13WetiDC4vbeP191JEph5iykJAm20eT1Rp1dlvyZ1O8E16yUonhTfevAsHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0A+7DvS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0A+7DvS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770279381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WHIZET8X/6ciVZP7QbD2OHfADqDoA3kbCcvEcXCKcO0=;
	b=U0A+7DvSSaehiPb7kLFOuKx5CaA7YEw5DT6RU44c5RUfufQtw8rjTE1otbMgPVLvrBZwyH
	Dz5ggCCo5jFl5XI+s4C9rRhwTni763b2Dml6Ov0p1cmEqorb9fgEanp/FOoKm8YNFnQB/p
	fvRl2AEZy2l4VOGR43p+tmY36JCiWa0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-Scy-0HLaMESy7hY6JcEUlg-1; Thu, 05 Feb 2026 03:16:20 -0500
X-MC-Unique: Scy-0HLaMESy7hY6JcEUlg-1
X-Mimecast-MFC-AGG-ID: Scy-0HLaMESy7hY6JcEUlg_1770279379
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43284f60a8aso544570f8f.3
        for <linux-cxl@vger.kernel.org>; Thu, 05 Feb 2026 00:16:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770279379; x=1770884179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHIZET8X/6ciVZP7QbD2OHfADqDoA3kbCcvEcXCKcO0=;
        b=RpRHw58jvWnJlC83gYHanH9BsNqb6qCTZNWC4qpDIR9XWdiFEsXNKRlnH6MtTEErEa
         FTpvtdnMAK/e4TDLPOiW5PcWDaDOR1teQQZlfclKHSy3RT2dyKITw3CS6isIA3RWvMbC
         0NAQIf49HYVzVhiDyT3e6++IWRidF2jW+fACHq6s7+8koqYAZOew3eCDwHadcu6exp+T
         hBvHBXr3/MZvyQgF9kCFeKkGTcMFPncwVyBC1ATXXq6ZH7oMVEfRoPe/cm69IxXGhtCo
         tSr/77wm6T2Ui2657v7+7JsYhog90RV+EFPOzj+FoTOefxCTUJ0KmIW2vSlhCajXFpwc
         wcLw==
X-Forwarded-Encrypted: i=1; AJvYcCU4EMalu18A/nAtljwD6rLhjp41JDQPXTB7sRkwrOEPh1yimm+jXedPgg0TCk5ILprwKLMeMBHer+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YysRb82/v4mcCKfSAjkgJlgfUR8H492rQj/dNPG11JlUkMwzmSm
	5RqJpszoXES6F0xjmwQ1IXGSGeHHJxJg1IDW03IfCF+SEb9MFaByh0/7sDR40Lq5BzWciuCchxz
	dWYhlRAvc+yzVPR20Vq6OlDbkejJxbNY+ORW374gCgW5e9uOf1K+6355b/Sq+gA==
X-Gm-Gg: AZuq6aI5ygQMx2JzBccvGHMwGi8FK6dO7R1gpqVSz7kTlfS7YOKRuK5k/q8Mgni+FsL
	weD8hY/jDQESU/jI/tpUZyhvYbrQakBbvMMXhXnWrfQGHAwG2fIbLbmdwaAeQDJpfxMh0bCrSrQ
	dMzRCKWh+LdErpXIYz1JTshT7SoqKQ3RNXLJKguMWTk/P+cB6RpOK2OLdGLxSzSg2wBsM9HK/Hi
	+JkYZlVH2nbC6QUzCANb9zhfx7GYDsjg/LGrNuhGORtyLWqlOL5GqF6EBFkWqNdi4H8IuG8IOdo
	1inz3r/9njvA1NfjxymxCfqtFOq/HHMWvHX5Rhen9PksyACgkf/f4PFOIjU/LE0bwCbN1GgoPkR
	1lMRgRmuiF0FYsabE0FJQ7UtV9PCQxus1mA==
X-Received: by 2002:a05:6000:1888:b0:435:9690:f056 with SMTP id ffacd0b85a97d-4361805284fmr7987357f8f.35.1770279379276;
        Thu, 05 Feb 2026 00:16:19 -0800 (PST)
X-Received: by 2002:a05:6000:1888:b0:435:9690:f056 with SMTP id ffacd0b85a97d-4361805284fmr7987302f8f.35.1770279378712;
        Thu, 05 Feb 2026 00:16:18 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e387b9sm13140397f8f.12.2026.02.05.00.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 00:16:18 -0800 (PST)
Date: Thu, 5 Feb 2026 03:16:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Jonathan Cameron via <qemu-devel@nongnu.org>, linuxarm@huawei.com,
	shiju.jose@huawei.com, Davidlohr Bueso <dave@stgolabs.net>,
	armbru@redhat.com, Fan Ni <fan.ni@samsung.com>,
	linux-cxl@vger.kernel.org, Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu for 10.2 0/3] cxl: Additional RAS features support.
Message-ID: <20260205031548-mutt-send-email-mst@kernel.org>
References: <20250917143330.294698-1-Jonathan.Cameron@huawei.com>
 <20251006101304.000055f8@huawei.com>
 <20251006062628-mutt-send-email-mst@kernel.org>
 <20260102152834.00003869@huawei.com>
 <20260204113526.00001040@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260204113526.00001040@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DOY_2_14C8aoXGT-0DqAc9Ril1rD9Mnc45W2vRB_CW0_1770279379
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2026 at 11:35:44AM +0000, Jonathan Cameron wrote:
> On Fri, 2 Jan 2026 15:28:34 +0000
> Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> 
> > On Mon, 6 Oct 2025 06:26:53 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Mon, Oct 06, 2025 at 10:13:04AM +0100, Jonathan Cameron wrote:  
> > > > On Wed, 17 Sep 2025 15:33:27 +0100
> > > > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> > > >     
> > > > > These two features have been used in testing the related EDAC RAS
> > > > > features drivers in Linux which are now upstream. Only minor tweaks
> > > > > from the second part of:
> > > > > https://lore.kernel.org/qemu-devel/20250811085530.2263-1-shiju.jose@huawei.com/
> > > > > [PATCH v6 0/8] hw/cxl: Update CXL events to rev3.2 and add maintenance support for memory repair features
> > > > > 
> > > > > I've split that series up as the two parts were only slightly connected.
> > > > > However there is some churn if this is applied without the other part of Shiju's posted
> > > > > series. That was sent a few minutes ago as:
> > > > > https://lore.kernel.org/qemu-devel/20250917141355.293217-1-Jonathan.Cameron@huawei.com/
> > > > > 
> > > > > Based on: [PATCH qemu for 10.2 0/5] cxl: r3.2 specification events updates.
> > > > > Based on: 20250917141355.293217-1-Jonathan.Cameron@huawei.com
> > > > > 
> > > > > Davidlohr Bueso (1):
> > > > >   hw/cxl: Add support for Maintenance command and Post Package Repair
> > > > >     (PPR)
> > > > >     
> > > > Hi Michael,
> > > > 
> > > > I see you have queued some stuff up on your gitlab tree.
> > > > Just wanted to make sure these are on the radar for possible inclusion.
> > > > No huge rush, but I'll queue some more series up on top of these
> > > > shortly.
> > > > 
> > > > Thanks
> > > > 
> > > > Jonathan    
> > > 
> > > thanks for the reminder, will queue.  
> > Hi Michael,
> > 
> > Looks like you didn't do another pull request for 10.2. If these can
> > go upstream fairly early in 11.0 that would be very helpful as we have
> > quite a few CXL series that I think are (nearly) ready.
> > 
> > I resent the events series but that was mainly because I'd forgotten you'd
> > replied to this one and so might already have both queued. Sorry about that
> > if you have them both already.
> 
> This is the second series that is (I think) ready for merge.
> Applies cleanly on mainline + 
> [PATCH qemu v4 0/5] cxl: r3.2 specification event updates.
> 20260119111542.788389-1-Jonathan.Cameron@huawei.com

question is if there will be v5 of that one, now there
are review comments?

> > 
> > Jonathan
> > 
> > >   
> > > > > Shiju Jose (2):
> > > > >   hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature
> > > > >     attributes in cmd_features_set_feature()
> > > > >   hw/cxl: Add emulation for memory sparing control feature
> > > > > 
> > > > >  include/hw/cxl/cxl_device.h | 145 +++++++++
> > > > >  include/hw/cxl/cxl_events.h |  47 +++
> > > > >  hw/cxl/cxl-mailbox-utils.c  | 566 +++++++++++++++++++++++++++++++++++-
> > > > >  hw/mem/cxl_type3.c          | 169 +++++++++++
> > > > >  4 files changed, 915 insertions(+), 12 deletions(-)
> > > > >     
> > > 
> > >   
> > 
> > 

