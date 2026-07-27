Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2383F3281
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150370; cv=none; b=ZoRnUYn2Rd3Dd8G5xr++y3kQwle1OQMz7VKUcjAMWDkI7m5fF4qYbjy6skX5z1LoXtsWdky9GM/lWaTygJDkK42hwcQo0AB8h2cFRO5FjHGTMdv3eg44h/qA9rHAFoYNPZOR4EtOoXRjWp7yj8h9PdFuY4z2ug7y96VRV3M3/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150370; c=relaxed/simple;
	bh=NpFNgdnVryn4ob88qxO9x6GjtzYEsVeXKDDlNjGzo0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=byj5GoRBOlsJmNysL/b5w5EM+kfnrMez/vG8aSoNDFnM4X+/GlFulgXlVFT1cUBzIQB5DQ6Gk0hgqgQ4sv4+XcddCMkhC1unkUmVJtpsimFM+WHuXhA7tVh8bZOXBJJQjZDPsDEBBGY2d+I3osOBm7Wxd6W0SSpKYH64IuvugVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6Z9eBK+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6Z9eBK+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785150367;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R16KcF6eEceIJ47/T/uJgZYu0MqYFlFXA4N2MOKufh8=;
	b=V6Z9eBK+B0d0oIl6/98vn/7uowYgbtGdUSjw+9W8obVNFujAQ4Ioi+gItLYDavB9egYyVx
	7h2MRKEyN/gH6EruumqZ0hrjSz9KVwIBDRWtJ+XatfB6CaAGd5nd7TgvfTH+ypAf8Req68
	/UQEG8M5dvoH5z7sjPFLSQz/XXcmXe4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-Vb8SiA_EMquHF2lWt_7PpA-1; Mon,
 27 Jul 2026 07:06:04 -0400
X-MC-Unique: Vb8SiA_EMquHF2lWt_7PpA-1
X-Mimecast-MFC-AGG-ID: Vb8SiA_EMquHF2lWt_7PpA_1785150361
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D7671955F6F;
	Mon, 27 Jul 2026 11:06:00 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.196])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCD025AA;
	Mon, 27 Jul 2026 11:05:51 +0000 (UTC)
Date: Mon, 27 Jul 2026 12:05:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
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
	Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
	Haotian Jiang <jianghaotian.sunday@gmail.com>
Subject: Re: [PATCH 1/7] hw/display/virtio-gpu-rutabaga: zero-init capset
 info response
Message-ID: <amc7i7-2N5fgXt39@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
 <20260725-fix2-v1-1-5c9a6ce7b96a@redhat.com>
 <d6876e8f-1414-4e7d-b6e2-1b59a18e8288@rsg.ci.i.u-tokyo.ac.jp>
 <CAMxuvawR=TiF4r+wdVCDF3Hyu-ND9neFHjUEZn5_YnSbxweXhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMxuvawR=TiF4r+wdVCDF3Hyu-ND9neFHjUEZn5_YnSbxweXhg@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 2QCKkQr2FfXTuNg7ARpXJNeWH7geR1kGKJRQ3y_Tsu0_1785150361
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Jul 26, 2026 at 12:24:52PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Sun, Jul 26, 2026 at 11:33 AM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >
> > On 2026/07/25 23:00, Marc-André Lureau wrote:
> > > rutabaga_cmd_get_capset_info() only fills in capset_id,
> > > capset_max_version and capset_max_size before sending the response to
> > > the guest. The remaining fields of struct virtio_gpu_resp_capset_info,
> > > including hdr.fence_id, hdr.ctx_id and hdr.ring_idx, are left with
> > > stack garbage and leaked to the guest, including host pointers useful
> > > for an ASLR bypass.
> > >
> > > Zero the response first, matching virgl_cmd_get_capset_info().
> > >
> > > Not a real risk thanks to -ftrivial-auto-var-init=zero.
> >
> > GCC only added -ftrivial-auto-var-init=zero in GCC 12, while QEMU still
> > supports GCC 10.4/11.

Opps, I thought we had new enough versions already.

> 
> Good point, may be we should update:
> https://patchew.org/QEMU/20260723094622.1515831-1-berrange@redhat.com/

I'm inclined to bump our min GCC/Clang versions so we can assume
zero-init.

We picked 10.5 due to NetBSD, and CentOS 9 still has 11.x

In both those cases, however, Clang is available in new enough
version to support -ftrivial-auto-var-init=zero. In NetBSD
there are also many new versions of GCC  available, only the
base system GCC is 10.5.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

