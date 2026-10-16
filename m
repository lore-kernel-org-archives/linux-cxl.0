Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9E54DD3AB
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163858; cv=none; b=TXjnDlcbWpr4MRdJfaSerlU/6wDfdnUrjMAhOXhYMPorRFxsJ115OK1fLO4Js0PA0U0Kxk8nKg0V/vzzyTpvxJ/WGN7Lc20V3HFjJPs3coS536rfG9qLB4xXJ489zgwdpUAB3U0AH6XoObea8YTV32ZOUBn1DzkoVPrOoRgf0C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163858; c=relaxed/simple;
	bh=AMn+xnR9hCYE91pZuVzz0iZ7IzoIrx1xBUWmAYY8/sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KT9hPVRPDqgTMybt0cFBQ3VHsYFesmg7Dpif4rsRXkTtH2G9GeSMBtq8eFUXut/ci1kyizQlMWCi1aa1CxBKO9HAkSlq0R82zv30vW7+7SWIn6QgXYqh7HXJsvPNYMLR9VHpb6OdDR0pvKVn12HtpLaxyh2xjcN4Kz22099XooI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J43XhuFf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J43XhuFf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792163848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3YoLdvr5Z3l3Hzqb5bH27bGqI1NT3+cZcFrMWvQlNUM=;
	b=J43XhuFfVutPr8H8f4fqPFI7Vzu5nj66m2KY6VwHm4SYBgmYEdILTdC+e461ttF5mc9Q2S
	EHdnUfs8gtH+RTvu+RJEAXJkfu9sTpc45LllijZHzqgGgD1aA8STXK1AkLfYNMM6wVPf1D
	LVt5970wuvgUHD1/TO4gFNCQz6tpmuk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-qgfmKqZtNhe45-Ghseer7Q-1; Fri, 16 Oct 2026 15:17:26 +0000
X-MC-Unique: qgfmKqZtNhe45-Ghseer7Q-1
X-Mimecast-MFC-AGG-ID: qgfmKqZtNhe45-Ghseer7Q_1792163844
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1612c4b80so635755e9.0
        for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 08:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792163844; x=1792768644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3YoLdvr5Z3l3Hzqb5bH27bGqI1NT3+cZcFrMWvQlNUM=;
        b=COMlhO7KepO6lBR/uPzpfxKiA1UMqvskQP83pcHHx9zISfd0FE8RKC5teWD/L23iM2
         QMnVBamAECfTT/sfjMlQNY7nU49hljxr2H+Ol/zAvVck2JK6S63EvDjQ+QPQqOianDt+
         fHCKmE87w22aajBik1fRI2qpSpZhed69LPesVM/Cgg3oS2e2Cp4E1uHKYSK5+jWroVZo
         4rJo4coxE0V3KQeCL/8kSITPPoKa9PrcezAmXbnXmV7ORMjLxBLjo93hpIhFCx9mj+v8
         VGGeCa/Vwc6FsTcr7ClFmoFAIsno1E/DHK89xDFOVZYBfn4EN7eUTxNjucFDBnxhOIhx
         on4g==
X-Forwarded-Encrypted: i=1; AKwUvBz1/aup7kHQAL2Zafb6tInJHXhdVlsnt+HTrLVntaG9ZfBtG6vIfmPlmVb9mQGF+voIxuzPWWXrAM0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsoHZHOWL92TcdzxBIFd73exBO1mf9yEEXmLpF0vMPPwuGaYU5
	HmhoNMl85cmibP+ejQ3LzfE28boJUxAxmIy9+Tg6twKCYWNtTwGyRfrMl4v1L04gvUOX8Q+szvF
	bszebU4Otk/2CcUxdwCut56wwuKTOVEGLjtEb6ikIqy7vH3MMJts2rpH6Di+JgA==
X-Gm-Gg: AYBFou157ue0keaAz4mdmjr3b8+uvVW1fr+yn42xqXsEmmzn4hn8oeK27x3BRsmoOTU
	VeZt6Gs22Cw0JFWfV1oBTYaZEZeTrBIB2n2k8pJ1MlfFRVf36VNk73BBUSjY2jERXWsUFzg6MfN
	s+KwFSAGdq7sUY9e+2iahe82mG1hi58GZ/Bkh7C1zdV9v3iYjjNQJQkgZUL8iohHgHEUzZ+aLgo
	5QqGEI+EQ7AYc15STfBurFAoIDD4QY3AmOmWp5JvPRO8IWSBlK0v6NGI+f50TfryCUGWWh7MKsv
	XZi3rUc9bWgg34jTrq3KTIxOd+y+nQXE1C7azQxKiI6qVfTp6WddwGZBtUfNPZW4SttXqZ4zXCV
	DzRUgp8L2Mn/Jf7ZqbHvc/Q==
X-Received: by 2002:a05:600c:3555:b0:4a1:d52e:c2d9 with SMTP id 5b1f17b1804b1-4a1d762c1bdmr2093925e9.23.1792163844146;
        Fri, 16 Oct 2026 08:17:24 -0700 (PDT)
X-Received: by 2002:a05:600c:3555:b0:4a1:d52e:c2d9 with SMTP id 5b1f17b1804b1-4a1d762c1bdmr2093325e9.23.1792163843743;
        Fri, 16 Oct 2026 08:17:23 -0700 (PDT)
Received: from maszat.com (85-67-2-18.pool.digikabel.hu. [85.67.2.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8de7230sm64621665e9.14.2026.10.16.08.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:17:23 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev
Cc: John Groves <john@groves.net>,
	Amir Goldstein <amir73il@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: [PATCH v5 02/10] dax: use READ_ONCE() in dax_holder()
Date: Fri, 16 Oct 2026 17:16:29 +0200
Message-ID: <20261016151638.2962413-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261016151638.2962413-1-mszeredi@redhat.com>
References: <20261016151638.2962413-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0DnGSMYsBExyrZnGiCEyNblbYuVYELFwHadvqUWKc7g_1792163844
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

A future fuse patch will utilize dax_holder() in RCU context to make sure
that the holder can't be freed by a racing fs_put_dax.

This patch just makes sure that dax_holder() works properly in such a
context by adding READ_ONCE() (equivalent to rcu_dereference minus sanity
checks).

Fixing XFS is out of scope for this patchset.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 drivers/dax/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 25836f389bde..76e8d3654629 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -642,7 +642,7 @@ EXPORT_SYMBOL_GPL(put_dax);
  */
 void *dax_holder(struct dax_device *dax_dev)
 {
-	return dax_dev->holder_data;
+	return READ_ONCE(dax_dev->holder_data);
 }
 EXPORT_SYMBOL_GPL(dax_holder);
 
-- 
2.54.0

