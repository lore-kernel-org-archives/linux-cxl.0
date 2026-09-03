Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB3C4582E0
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436804; cv=none; b=AGyFgk9bV8Lh2KO+yaPtvCk18t6jwQD7j6jhofiKiD8+DSWAe7l5ysysS1kYLRkUPg9MeaoSEltgAqLh+cYZh3ji8MDNlPBH3aKA/VwSaNtWsKL9qXJUMiLcXLttPc/6m4JNFEk8/rsuSQdl6T+dGGzXPk2g2/wiNm0Y/XlH+og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436804; c=relaxed/simple;
	bh=wET2hheVOXu2dloDjPLhB0/+IUvdyjY2j1T9fRYhgpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NoXTedPGJ3nFvOVsCBKPc8vXgyQn/amEU/iPiNNTfW0AXGNH5ZAVy3uqPpE3zy5sbsjnWzN5sMR8TY4/BYTC1G1hjsYGuVVZ4jQfQBGO4xuCZK6GC2iU2bjulSepYYJr8AUaPgVn2uwUDLeAFoYGSFpC/QF8whaCgduvJrAkFlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MOxppgHs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOxppgHs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788436801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wET2hheVOXu2dloDjPLhB0/+IUvdyjY2j1T9fRYhgpI=;
	b=MOxppgHsYyzafrdKQ7NdcWWC+k6n6uPuap81abD4AzhUiWg/Z0ztLU9tG5jrwtQgv8wPHk
	pCYVdBAHywT/KMxiUjFlCdEhBnwADs5zvftm8kJ2G7f1YW70Tr0LyQtdNt6UYFxvA1icx5
	UW8PTUnKE1vNgoe3+jEYGxTZowtJayg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-n-pXnJEsPEONAICU2_BpEg-1; Thu,
 03 Sep 2026 07:59:58 -0400
X-MC-Unique: n-pXnJEsPEONAICU2_BpEg-1
X-Mimecast-MFC-AGG-ID: n-pXnJEsPEONAICU2_BpEg_1788436797
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 440C7195604E;
	Thu,  3 Sep 2026 11:59:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A62493000239;
	Thu,  3 Sep 2026 11:59:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 34D8521E6837; Thu, 03 Sep 2026 13:59:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Hanna Reitz <hreitz@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Ani Sinha
 <anisinha@redhat.com>,
  qemu-block@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,
  linux-cxl@vger.kernel.org,  Jonathan Cameron <jic23@kernel.org>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Markus Armbruster
 <armbru@redhat.com>,
  Kevin Wolf <kwolf@redhat.com>,  Lukas Straub <lukasstraub2@web.de>,
  Fabiano Rosas <farosas@suse.de>,  Eric Blake <eblake@redhat.com>,
  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Zhao
 Liu
 <zhao1.liu@intel.com>,  Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 00/12] qapi: convert simple command intro sections
In-Reply-To: <20260901194324.458482-1-jsnow@redhat.com> (John Snow's message
	of "Tue, 1 Sep 2026 15:43:12 -0400")
References: <20260901194324.458482-1-jsnow@redhat.com>
Date: Thu, 03 Sep 2026 13:59:53 +0200
Message-ID: <87ik4mr1dy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: cM8PxMb5Iplm8TQwlLUE_bEBVCnLh6jLtwxzLt2N6FY_1788436797
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Series
Reviewed-by: Markus Armbruster <armbru@redhat.com>

