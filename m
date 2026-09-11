Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E935200F
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117345; cv=none; b=ezE0sPcpW9RmfsaL9kLmJY1rtglcYfBffUs7l55kiF9wt7iAXSkigmHg4hhJpY+KfdK2hA0ShQXEXr1v5Fuk/C7n5hJ9EBN+amhsFLZXreXeirA9IUNn5N4asgYKSnXuRt6teyAsLSRdiyj0hEK726xoQEDV9J70ZoIdLLt+2+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117345; c=relaxed/simple;
	bh=wET2hheVOXu2dloDjPLhB0/+IUvdyjY2j1T9fRYhgpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rje17KKcdN+Ygk1eqUyVyHo7smP4FdbD091xNTSkBTe8+kFGEpUywNALE4w4F90I62JrWvuDM/gblzN2eqi8jy8VRuRaVAO+j1FOdTULrTEJuvi6NqmpYCXiM1RK++R2CP23NDNCjCos3UhABPAtAdZXlJL7sFwK3HqAGOPiwSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJskulPc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJskulPc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789117342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wET2hheVOXu2dloDjPLhB0/+IUvdyjY2j1T9fRYhgpI=;
	b=bJskulPcyq7zaI5E1ivfInDw19Fvbm4l53qc0X/Np1HIlxMRSN3uq+Wy6U6rs6PEaNFW19
	YsVORcwadX+zvBDzaGWHuNlCalcKkMRx0PG4dmksYWAG+SHCvshf1s5+jw7HIbLFefNzgp
	Ob4hcEXTrp9caGlKEzIVUguokZx7XR8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-kBeqOlOwNgW4_xxa2nGaLg-1; Fri,
 11 Sep 2026 05:02:19 -0400
X-MC-Unique: kBeqOlOwNgW4_xxa2nGaLg-1
X-Mimecast-MFC-AGG-ID: kBeqOlOwNgW4_xxa2nGaLg_1789117338
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D618F19540C8;
	Fri, 11 Sep 2026 09:02:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AB631800348;
	Fri, 11 Sep 2026 09:02:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 1795C21E6A04; Fri, 11 Sep 2026 11:02:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
  Igor Mammedov <imammedo@redhat.com>,  linux-cxl@vger.kernel.org,  Zhao
 Liu <zhao1.liu@intel.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Lukas Straub <lukasstraub2@web.de>,  Jonathan
 Cameron <jic23@kernel.org>,  qemu-block@nongnu.org,  Ani Sinha
 <anisinha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 00/10] qapi: convert simple data struct/alternate intro
 sections
In-Reply-To: <20260910203856.99003-1-jsnow@redhat.com> (John Snow's message of
	"Thu, 10 Sep 2026 16:38:46 -0400")
References: <20260910203856.99003-1-jsnow@redhat.com>
Date: Fri, 11 Sep 2026 11:02:15 +0200
Message-ID: <87v78c88ko.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: Z7hmOQ62XDgF8Wt3JKOgcdH91QUywhhjBcsvbspZ9k8_1789117338
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Series
Reviewed-by: Markus Armbruster <armbru@redhat.com>

