Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C3242D8B
	for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765957915; cv=none; b=AzoY2oRf3nPpQHTV/YENyVm1SbnfKWr+cK2X5kp64JYWfSVxetBbCfqL/swRyMR4YOYeJ8lrfreE8TPWQ0AqhEAVrLtnfYSIS0J5kftv/FSw+zbumjw9I0tJ1jWIRgwvhyiZibpopNKPr5gyvynOHfIdQtG5FoTbIG6A2/FGPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765957915; c=relaxed/simple;
	bh=5oi8AeY7r1ROv41H920zZQdhTlJpts7iZQ/VfdSBbDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kgjHSp4by2uYKenhiSUVAMlnW7JqTfkQpbY41u4DF83RMpK70rxgiek8j4XWhEKOzzYs+5xLuVlBYmRoFfRCckStuObzzT8waoU4E9JruxJTRzJsY2FXC+fvXS6NObD1JVYXwUdap3yFpjOslFWJ6c2xreX77FKhe1VisfvhCVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4d1vZ1i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4d1vZ1i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765957907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F6m7e1qWD9XjNZ4WVxqD47/l0CzjKshX3ahDOv/Zr7U=;
	b=A4d1vZ1ifTK+1WC0r7qijcR3u5CcJTE9BQxeSgWOsNdkG7Dg+7EPOOiq7HIPMfHG1CDbSq
	54D6Z0iw6fNjrpDsqZaeJWO+SFvaqTwBHIJUEJ7SaDWQhvjhbU2mJeeuynajG95ibYFQwS
	Fim87jWhxPT9HLLr0Ncqih8K6QRToBc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-Tw_11YzCM36lJCbsAfWl3w-1; Wed,
 17 Dec 2025 02:51:45 -0500
X-MC-Unique: Tw_11YzCM36lJCbsAfWl3w-1
X-Mimecast-MFC-AGG-ID: Tw_11YzCM36lJCbsAfWl3w_1765957904
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76A75195605A;
	Wed, 17 Dec 2025 07:51:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4EF51956056;
	Wed, 17 Dec 2025 07:51:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 7738D21E6A27; Wed, 17 Dec 2025 08:51:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com,  ira.weiny@intel.com,  alucerop@amd.com,
  a.manzanares@samsung.com,  dongjoo.seo1@samsung.com,  mst@redhat.com,
  marcel.apfelbaum@gmail.com,  linux-cxl@vger.kernel.org,
  qemu-devel@nongnu.org
Subject: Re: [PATCH v4 -qemu 0/5] hw/cxl: Support Back-Invalidate
In-Reply-To: <20251216152411.mlx5tgsdwnjss7ku@offworld> (Davidlohr Bueso's
	message of "Tue, 16 Dec 2025 07:24:11 -0800")
References: <20251103195209.1319917-1-dave@stgolabs.net>
	<87cy4esysa.fsf@pond.sub.org>
	<20251216152411.mlx5tgsdwnjss7ku@offworld>
Date: Wed, 17 Dec 2025 08:51:40 +0100
Message-ID: <87jyylo8ab.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Davidlohr Bueso <dave@stgolabs.net> writes:

> On Tue, 16 Dec 2025, Markus Armbruster wrote:
>
>>Davidlohr Bueso <dave@stgolabs.net> writes:
>>
>>> The following allows support for component basic back invalidation discovery
>>> and config, by exposing the BI routing table and decoder registers. Instead
>>> of going the type2[0] route, this series proposes adding support for type3
>>> hdm-db, which allows a more direct way of supporting BI in qemu.
>>
>>[...]
>>
>>> Applies against branch 'origin/cxl-2025-10-03-draft' from Jonathan's repository.
>>
>>URL?
>
> That would be:
>      https://gitlab.com/jic23/qemu/-/commits/cxl-2025-10-03-draft

Have these patches been posted to the list?  If yes, Message-Id or
archive URL, please.

