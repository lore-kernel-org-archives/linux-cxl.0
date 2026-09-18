Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642D43033FD
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718604; cv=none; b=kbo40Ji1Edf8XUpz1stQ5mM+CHBIL6zEVmq1JY3atB2mNG337CQwYFMD7ngVpQoANV9QxB9qFrG5Xe5AdSq3z9mxx4+8ZwIqJwBUMTPIyYzK8ho9U3wtvunWgRqhj/dFVx+6xE1IGbRZn58Z5s7sSaSKCtgBh/uWgZSBGcJs6M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718604; c=relaxed/simple;
	bh=wET2hheVOXu2dloDjPLhB0/+IUvdyjY2j1T9fRYhgpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eQ/9NSSmJ4zPjlql+UsfLoBbGol486YhDDPY2D6e5lYYAYpMUKcCt7pxz4HZSDF01nrPen13hRFwd6XdjVp1lQz/4D0IusQdFxcoftDoegLI2oc/M8D5YmTKDfiscCF0RDY91DPEpzRnXoVJuv9a3jXBJEx3UUbZtFXfBEAppa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrTFl8Sl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrTFl8Sl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789718602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wET2hheVOXu2dloDjPLhB0/+IUvdyjY2j1T9fRYhgpI=;
	b=hrTFl8Sl1Sss0FLdTZtUtX17bnWfGZUX2xjW1I2u3pnrRatm6XFUNfJrycBcYbDjkDaJmd
	luT5/AIdEI3Qm1U9jYj2oprf7agBqSRDsDGjMmKeG0NFUQpoLNnQTH9woO2fbLRTzDcH5u
	TYAOki6LnjCZaD81Wc3GGBwIFyryTjM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-XIi9-0OAM7eGss4phnzHqA-1; Fri,
 18 Sep 2026 04:03:17 -0400
X-MC-Unique: XIi9-0OAM7eGss4phnzHqA-1
X-Mimecast-MFC-AGG-ID: XIi9-0OAM7eGss4phnzHqA_1789718595
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42EA1184B38E;
	Fri, 18 Sep 2026 08:03:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7703D1956047;
	Fri, 18 Sep 2026 08:03:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 18F4521E6A04; Fri, 18 Sep 2026 10:03:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Junjie Cao <junjie.cao@intel.com>,  Michael Roth
 <michael.roth@amd.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  linux-cxl@vger.kernel.org,  Jason Wang
 <jasowangio@gmail.com>,  Eric Blake <eblake@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,
  qemu-block@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Lukas
 Straub <lukasstraub2@web.de>,  Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v5 0/7] qapi: convert remaining "simple" intro sections
In-Reply-To: <20260917194614.549584-1-jsnow@redhat.com> (John Snow's message
	of "Thu, 17 Sep 2026 15:46:07 -0400")
References: <20260917194614.549584-1-jsnow@redhat.com>
Date: Fri, 18 Sep 2026 10:03:12 +0200
Message-ID: <87o6dvnfzz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: f2jDX2kSxOlFfKYmhxehx3cj2YxgZy3O7xSyJMpmuf0_1789718595
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Series
Reviewed-by: Markus Armbruster <armbru@redhat.com>

