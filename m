Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194CB47A0C7
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260746; cv=none; b=Kngv7W+ciXR0SadmUwK9STmFwz9pqhFFQXtXkVnekAVcwqcw/ytV2Xx6V9kZSXizISC0wKsETcQW0iQFw7wWco3Lh15fSKFEPJwjk4adwmoEGOi3XbF3DlSesvDPjIwfh1VU02DRwn63dK2lBHlcfToAn0T0ZLivQ4bAiLI9k1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260746; c=relaxed/simple;
	bh=wET2hheVOXu2dloDjPLhB0/+IUvdyjY2j1T9fRYhgpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a1Uc7PcfGVU6RC4e85M/h74s0HMdteAb2a9KLN4llqh9C0oHXfPxszKsLuvqLi8ib+Kt3b8+dPnZ28UIoBOLlYfH7INdiIHlxDQNJr7DEdFp3g8QkD7CJpItqSo25768rO0Fq2SKTu0IM7bbDrf5EcvFVz8qgLWJbmWnwy+Em6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NumK7bAk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NumK7bAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788260744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wET2hheVOXu2dloDjPLhB0/+IUvdyjY2j1T9fRYhgpI=;
	b=NumK7bAksoZMOhMEtQaj/mv9dkHamqKzFPYwEGawhnUJGw13X2R+m2q3SO22BP4C/6kvTW
	Hj0qdF1bRn0JRH5o+kJvK+kLc7/LRG43GNWS8wAd/f8vpD2uJ/J8szPnf88EtNnEPx0Mxa
	ogKY6lGcZrhP8/LQyQLXZkNradWohG8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-xOWqWDWeMjqMYUd6-o2HBw-1; Tue,
 01 Sept 2026 07:05:39 -0400
X-MC-Unique: xOWqWDWeMjqMYUd6-o2HBw-1
X-Mimecast-MFC-AGG-ID: xOWqWDWeMjqMYUd6-o2HBw_1788260736
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D8C41845537;
	Tue,  1 Sep 2026 11:05:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE47A1800257;
	Tue,  1 Sep 2026 11:05:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 3A38021E682B; Tue, 01 Sep 2026 13:05:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
  Lukas Straub <lukasstraub2@web.de>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  zhenwei pi <zhenwei.pi@linux.dev>,
  Jonathan Cameron <jic23@kernel.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Jiri Pirko
 <jiri@resnulli.us>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
  qemu-block@nongnu.org,  Ani Sinha <anisinha@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>,  linux-cxl@vger.kernel.org,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Alex Williamson <alex@shazbot.org>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
  Laurent Vivier <laurent@vivier.eu>,  linux-edac@vger.kernel.org,  Michael
 Tokarev <mjt@tls.msk.ru>,  Fabiano Rosas <farosas@suse.de>,  Zhao Liu
 <zhao1.liu@intel.com>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,  Eric
 Blake <eblake@redhat.com>,  Peter Xu <peterx@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>,  qemu-trivial@nongnu.org,
  =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>
Subject: Re: [PATCH v4 00/43] qapi: convert (very) trivial intro sections
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com> (John Snow's message
	of "Mon, 31 Aug 2026 16:19:02 -0400")
References: <20260831201945.287730-1-jsnow@redhat.com>
Date: Tue, 01 Sep 2026 13:05:29 +0200
Message-ID: <871pbd9qpy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: HarriZV-jr7du4UhugQ4NUMt_6zjg-ql47e8cJ65ALk_1788260736
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Series
Reviewed-by: Markus Armbruster <armbru@redhat.com>

