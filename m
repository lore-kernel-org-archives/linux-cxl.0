Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4DF2D0C94
	for <linux-cxl@vger.kernel.org>; Sat, 12 Sep 2026 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789198630; cv=none; b=eNgKIDGmcc8mg7uQZtR/GnjWRWy18rlCe9Nd5SstGiVvnPQKo1KFdJQ7yf2fN1+2GoTaGDilyvbNrEEkBi4a0UGNZ9qUJKlEWjwrSl/lf+P4e4anzxo2DP1RVYBhRDPfQ81FlhUU3OOELi/vx4Yu1+yLHyT06pHyCJRNzjCy5HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789198630; c=relaxed/simple;
	bh=Iw4/I/xqdIq948E0o4OIoqyNFS3SYg1krcIDm/GjiqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TU8eeq6N5GLy5v9M6F8VBtmRBMK9DZCzkYQsAByy8GS34Qpp5w3nyYCJuAGbbWX29qbr2DMqGrMTixQP2RJK+thjrFtoJB1gD7sWEzz572l2aPkI5BcYg896GfkvnfpWfcaWBR3sEYDpYoyiMpJ0sR2+pfzNUnLEpGeUu/CTZ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QrOXh2xp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrOXh2xp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789198627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iw4/I/xqdIq948E0o4OIoqyNFS3SYg1krcIDm/GjiqY=;
	b=QrOXh2xpSNwppFPDHli6w0jP49n0buKlrnBADsiNSqMZjQmeXJYMt1Pa1w6YEvQunRkwxT
	OeVFX+JwkV5vV2toEnqVKviV845kgatWrGhc5pw2r8tER0FZ5Dlf84U1Mx2q3lxmdZqInN
	W/qAe8WMHMwwjGpkXEwyix+BIXmah+E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-vfnzptxMNgaWTM0pwgb7_A-1; Sat,
 12 Sep 2026 03:37:04 -0400
X-MC-Unique: vfnzptxMNgaWTM0pwgb7_A-1
X-Mimecast-MFC-AGG-ID: vfnzptxMNgaWTM0pwgb7_A_1789198622
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3AA1195DE7E;
	Sat, 12 Sep 2026 07:37:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 170861956095;
	Sat, 12 Sep 2026 07:37:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 9B07021E6A04; Sat, 12 Sep 2026 09:36:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Eric
 Blake <eblake@redhat.com>,  Jonathan Cameron <jic23@kernel.org>,  Lukas
 Straub <lukasstraub2@web.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Zhao
 Liu <zhao1.liu@intel.com>,  linux-cxl@vger.kernel.org,  Jason Wang
 <jasowangio@gmail.com>,  Hanna Reitz <hreitz@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 0/6] qapi: convert remaining "simple" intro sections
In-Reply-To: <20260911172200.227914-1-jsnow@redhat.com> (John Snow's message
	of "Fri, 11 Sep 2026 13:21:54 -0400")
References: <20260911172200.227914-1-jsnow@redhat.com>
Date: Sat, 12 Sep 2026 09:36:58 +0200
Message-ID: <87bja23opx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: O_FpZ8txLC6nNR5lkYKEMqsfdjH2Xvn9EbbJEnkbHKA_1789198622
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

PATCH 1-4,6
Reviewed-by: Markus Armbruster <armbru@redhat.com>

