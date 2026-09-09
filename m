Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11B242D70
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 06:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935515; cv=none; b=h/2gIIlGv2QAa49jTS04T+NOpPGoEmRNE00L5tupA4goiuxtNt8qAnXXBKaW6hZRGJBkSfX909h6YvCXcDEupQC8fGhq0/KPj/1gnbPWaaExk1LaHtJqaB0xWcf9eMJM+0BDSPWTxxbxdk/J/vJWFCV5N4PwF/+XyI48ecjEt7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935515; c=relaxed/simple;
	bh=wET2hheVOXu2dloDjPLhB0/+IUvdyjY2j1T9fRYhgpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=naVnUBmCcGZIA+BDs38KKS8ceeHkdtIWqlBSLKdW8o62kmY/ojS+eLRuYJhmyW04FTs4KxpG/xQp0Y1iOnVHlJQeTwUgb0Ev49edrEunyukuxtJ7noJ9T298mnAWqKeuGxZ8FnMJ+ibPHbSSXW4hYEbqR5XO1oPpnjYF9rQJMWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJOvA7qZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJOvA7qZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788935512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wET2hheVOXu2dloDjPLhB0/+IUvdyjY2j1T9fRYhgpI=;
	b=IJOvA7qZR+2YJP8MeYi2leHLP0ysSJkYr0VzShundjecKB4ShJN7Ija92PyVxyAGhDn01Q
	rGpP3DYxEJq2TGCWzZLCqJB6DepUeKiJ57Z8OtsN5sAoNapy6EfV0aAwAdFzD/4nphY+Ux
	wfQ1FTYLNvydW2nqU3A3JHkD8We3H1k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-LQ6DNbkdMB2Gg4AC9b4h_Q-1; Wed,
 09 Sep 2026 02:31:49 -0400
X-MC-Unique: LQ6DNbkdMB2Gg4AC9b4h_Q-1
X-Mimecast-MFC-AGG-ID: LQ6DNbkdMB2Gg4AC9b4h_Q_1788935508
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5223D1954AE8;
	Wed,  9 Sep 2026 06:31:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52D731956087;
	Wed,  9 Sep 2026 06:31:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id B6F8521E6A04; Wed, 09 Sep 2026 08:31:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  qemu-block@nongnu.org,  Eric Blake
 <eblake@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
  Alex Williamson
 <alex@shazbot.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Jonathan
 Cameron <jic23@kernel.org>,  Lukas Straub <lukasstraub2@web.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Hanna
 Reitz <hreitz@redhat.com>,  linux-cxl@vger.kernel.org,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 00/10] qapi: convert simple enum intro sections
In-Reply-To: <20260909041640.69080-1-jsnow@redhat.com> (John Snow's message of
	"Wed, 9 Sep 2026 00:16:30 -0400")
References: <20260909041640.69080-1-jsnow@redhat.com>
Date: Wed, 09 Sep 2026 08:31:43 +0200
Message-ID: <87y0dbndf4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 4278rP96HUJpxe1TMUAcGTDc8Kq590SAiWNf43-_ynw_1788935508
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Series
Reviewed-by: Markus Armbruster <armbru@redhat.com>

