Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E0C3A7839
	for <linux-cxl@vger.kernel.org>; Thu, 26 Mar 2026 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521750; cv=none; b=eJ1zMeNub6Rx64+hRVBxG50jamWuIyb3+TZAPraTCBtsStq1iyr6Q2ZRxFPrIMD8EOjCRXwahn2MegHhIlK0avkEf1kR84TbljeDhnOYR9+b14Bng08LRMItmcPBB9mA0v2vVHTQMVFR/+ycXKIr8dOMt2nAjvdoLNf2x9Ev3iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521750; c=relaxed/simple;
	bh=998cViLeJkKEBaad+bnoC/XHmEaYJIWNV0T/i/Fp4hg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B7jLHZdeD7YYO3MnYtfQfbOYFfDR6Q1Io1QpTeDMuBVywDSxFCPJnMdZQPQeG6zXC6hlDIwNvGbfN7Hg+Tp4mGtdHynR8kR4A2Qw5PrfBkknLh/AyjifdvCZ+W4cF3In1jR++esF2uh7oC2LTpW8fzRV1sXs+Un4T6TlGwclATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tb5YYGVw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tb5YYGVw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774521747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uRiVM/hQz0BvpG69+7beiImyjSsPHNvKncV4RQM/tmk=;
	b=Tb5YYGVwjnw7C1bAjM/3GcYIGrXD5f9l8VZWRjOY+sjNVHSrCUW9UzDUTkKeB9vei13Msn
	ycn7xEhLPRgYjIZZYTbRJq8z/4Jhn/tHTuuTh6OImLAQ8aZ1ONjk3Bba/J/TITgDCNGAz7
	VV67pTZcNy5E1rcw8iJOpQmukJFzBDg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-7NkrLcZKNYCwbta6h5sLGQ-1; Thu,
 26 Mar 2026 06:42:23 -0400
X-MC-Unique: 7NkrLcZKNYCwbta6h5sLGQ-1
X-Mimecast-MFC-AGG-ID: 7NkrLcZKNYCwbta6h5sLGQ_1774521742
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20E5619560B1;
	Thu, 26 Mar 2026 10:42:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB6221955D84;
	Thu, 26 Mar 2026 10:42:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 622E321E6937; Thu, 26 Mar 2026 11:42:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <anisa.su@samsung.com>,
  <berrange@redhat.com>,  <eblake@redhat.com>,
  <jonathan.cameron@huawei.com>,  <linux-cxl@vger.kernel.org>,
  <linuxarm@huawei.com>,  <lizhijian@fujitsu.com>,  <mst@redhat.com>,
  <pbonzini@redhat.com>,  <gourry@gourry.net>,  <nifan.cxl@gmail.com>,
  <me@linux.beauty>
Subject: Re: [PATCH 1/9] hw/mem: Add tag support to generic host memory
 backends
In-Reply-To: <20260325184259.366-2-alireza.sanaee@huawei.com> (Alireza
	Sanaee's message of "Wed, 25 Mar 2026 18:42:49 +0000")
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
	<20260325184259.366-2-alireza.sanaee@huawei.com>
Date: Thu, 26 Mar 2026 11:42:17 +0100
Message-ID: <87a4vuhnxy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: baL2JkNfG9isYiLAGWLYPNgSzmLzB64ragz_4qf5CFk_1774521742
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Alireza Sanaee <alireza.sanaee@huawei.com> writes:

> Add a string tag property to HostMemoryBackend so that backends can be
> identified by a user-assigned name at runtime. Expose the property through
> QOM and add a host_memory_backend_find_by_tag() helper that walks the
> object tree to locate a backend by its tag.

Why can't you use the QOM ID?

$ qemu-system-x86_64 -S -display none -monitor stdio -object memory-backend-ram,id=fred,size=1M
QEMU 10.2.90 monitor - type 'help' for more information
(qemu) info qom-tree /objects/fred
/fred (memory-backend-ram)
  /fred[0] (memory-region)

