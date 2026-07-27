Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78493C0605
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142631; cv=none; b=c2TohcIKG6QbBn3kM0sIqohzkIqHcjEqcYOCLFjV09qBMuzEAhVQJGAHg+JVqifDz01pWo6w2urzk9aR4bg5l2fxyV/TQBeXBwcahj0UgQLHKmrzabx0vq22wLqrzxpVcnUsXpFsBa9dnTEkR8pxsS7AyGasZqEB/lkWIgtcISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142631; c=relaxed/simple;
	bh=QDZM7uCYra16PSHALfP04DuGaAkJnX9UiPHave8ttlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tHosokmyRS/KKj9bW8gTAOkdEi0DjzKDwU17v/4FsAD4jXVLdWC405P6MAGRsqsb80zTQwHLqSCWP6ykcy46AXKluLu6UxeCpvPm9OhEBOmrq2un5BY+dO+7TyU3dFzrrlbnSX7YyOLFlEroY6IACjwyvwfGCfw/piCrAE1duwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hAZluQ6s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAZluQ6s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785142628;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crxFD0P0ZXGIhrd1TmHl2rpW636As26zHe98SmFQUmc=;
	b=hAZluQ6s0tXwp/qFHeeQzmvqPdjTm1+Jp89uKA92j77l/1/QoqCbooGzQYdH/QFBjFLyOe
	mhjUPPzyQwQDPpCyzQ+hbiM/ZLb47jNIDRoaeHoz7oPzmwebMFvJFPDpFygnsLsBl8KcVx
	IERXUJDvwhDxzYiYhxIM0VUBWn2NwBw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-Pk-VpThcNqe9xDUpAPDNsQ-1; Mon,
 27 Jul 2026 04:57:01 -0400
X-MC-Unique: Pk-VpThcNqe9xDUpAPDNsQ-1
X-Mimecast-MFC-AGG-ID: Pk-VpThcNqe9xDUpAPDNsQ_1785142619
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C68651955DAC;
	Mon, 27 Jul 2026 08:56:57 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.196])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91CBE3000F15;
	Mon, 27 Jul 2026 08:56:49 +0000 (UTC)
Date: Mon, 27 Jul 2026 09:56:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
	qemu-block@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
	Zhao Liu <zhao1.liu@intel.com>,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org,
	Brian Cain <brian.cain@oss.qualcomm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 07/12] Fix some -Werror=maybe-uninitialized
Message-ID: <amcdTq2T2y-N1pmO@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-7-d0c4831ed7ea@redhat.com>
 <20260726165049-mutt-send-email-mst@kernel.org>
 <CAJ+F1C+jzxfbWbmLoU6vMobKUr0VFkpnr--FyPcy8o1=Q0vY-g@mail.gmail.com>
 <d9c4321c-ed39-4da6-926b-bae4b1491a52@rsg.ci.i.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d9c4321c-ed39-4da6-926b-bae4b1491a52@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 9BsSp0_69PFc4a-zT37Jw1IAQJd5DdoylSv5gs-eN0k_1785142619
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 27, 2026 at 02:25:39PM +0900, Akihiko Odaki wrote:
> On 2026/07/27 6:07, Marc-André Lureau wrote:
> > Hi
> > 
> > On Mon, Jul 27, 2026 at 12:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > 
> > > On Mon, Jul 27, 2026 at 12:44:06AM +0400, Marc-André Lureau wrote:
> > > > When compiled with -Og, gcc produces many false-positives
> > > > gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2).
> > > 
> > > it hurts if you do it? so don't do it then?
> > 
> > We are not far from getting it working, we can accommodate a bit of
> > code while making it a bit clearer for the reader too.
> > 
> > > 
> > > > We already use auto-var-init=zero, but better be explicit.
> > > 
> > > explicit about false positives?
> > 
> > Explicit initialization
> 
> These are the same concerns I raised in my previous review:
> 
> https://lore.kernel.org/qemu-devel/f919e684-93ed-4eca-8ddc-785e69dd8add@rsg.ci.i.u-tokyo.ac.jp/
> 
> I do not think this patch make the code clearer. They add values that are
> never consumed, which obscures rather than clarifies the data flow. Leaving
> a variable uninitialized until its actual value is assigned makes that flow
> more explicit.

We've seen time & again that human reviewers fail to reliably identify
when variables are initialized vs uninitialized, leading to countless
CVEs over the years.

We want everything initialized to reduce our security risk profile.

We added auto-var-init=zero as a backstop to have implicit initialization
on the basis that zero-init is the right thing to do 95% of the time.

None the less, we should be adding explicit initialization to everywhere
so that we're clear about when we want zero vs non-zero initialization,
plus a few places we explicitly mark & disable initialization for
performance reasons.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

