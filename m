Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282C49E5E5
	for <linux-cxl@vger.kernel.org>; Tue,  6 Oct 2026 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309690; cv=none; b=WJvKkTUVIDT8d6oW40B10xlZ0OkEadBMdiR6sDm2ES9bin+zo6Dok8p4yXdgZLrq85QhIX2Z6/08DUNdz6nsdTtp2zKbezwD3d8kzrt6mWTkW0naSqajQCmbkX6OQONq81DAJzuSZfzqBdbR/xboat12OTfUeXaViEMvRNf1VBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309690; c=relaxed/simple;
	bh=fgSnuoTru0M1RdnWdJ3W+h1U533c9s6oWqTxjipvO2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=bY7gYUMbL8bAky0aR/LsL48+lwu7E7Od0bWkhyv+7uGjwELLEEVNUGSF+LYQlLiV/K96DnbICEeZ018ylqnUgyCtroKPdavCbzW5HTpSznfY0BrOzicU2l3Kb/szyRJbETkahe/HeOYchXEjSQLcx1xbTb6ynBeOUQvwCswsbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZzxoPxM8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzxoPxM8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791309688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yukm86LJzzz9J8hnEhUh3B7rrcrjSUe6dcN4L+kFZ5U=;
	b=ZzxoPxM8Icd6aVjXUXh6igM4k5Rnh7lJdvpBGbZjaeCqreqNvVO1HoykmcyfrEj6PeTAzU
	M2E8ZEHMn5a1nqcUO34vPjFXa3y+V+I5c4kuQ9+ogliWkjS6HyehKdJ5J/6MEQ+p/C6oGC
	WlKAihPklIjyTMkcoc3/Z7qhCo/SjWk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-1MC8FS_ZNTub2bQE8RQHPA-1; Tue, 06 Oct 2026 14:01:27 -0400
X-MC-Unique: 1MC8FS_ZNTub2bQE8RQHPA-1
X-Mimecast-MFC-AGG-ID: 1MC8FS_ZNTub2bQE8RQHPA_1791309685
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6ae551724a0so2410655a12.2
        for <linux-cxl@vger.kernel.org>; Tue, 06 Oct 2026 11:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791309685; x=1791914485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yukm86LJzzz9J8hnEhUh3B7rrcrjSUe6dcN4L+kFZ5U=;
        b=20t2vopLBIXd09wozVtgQCsfYoxNte1pAmde9ng99ad9J7LZcbM29mVLIzmOoJDNv+
         EYHkNRHtRGW0XGsoDd8t6QilXDMeVmGgJgqI3uliHjvm/RWIRwZ7PAU7jh+bSwYnsqCr
         EN5g9LQj3Jb4kJRf4SzL3x4UF44qjiXz1CQf5IigXN/JWQc30CivdVO+Lz7i5pm4dqNx
         uITn0TIMPZ46xJf7MaYd6xhfO7BZGUYA33dXreFed7rmU+VwMKlU/zCtoNs55AfmV0h1
         mjBzT5TOofSWTQbcyTuugms5R4E2GxZnY1c+fu4dHyxLAWuIi3APhnz4TrKTjqiuFl1R
         7SDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxSoVO35SxDmcYO2bOwgjLxH+ZJHZmjONDGoiB/HYsqoYDFxcWb7bMmzn3S9kx9Td9vbBnfwInKl0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7JzTEdyg/qo4ifx0AqPGlykCOwQIsP6Ypc998In2NmCVgHeY8
	SOobO5WEQcrcYwxhUGh3/bEU6/86oIC0Csr25quPgkTRz/+Ct6XI6yvVCtrL3OicxU4f+wKICSZ
	X0lxaoCtv21ma4qEURVcJOKOkAUt3dDdkCZY+fdGMhkywcAAH2D/8FmWLhlm0gA==
X-Gm-Gg: AYBFou3KZdOOTz6EClX0hT4Eev3zx8stGW8thmQty6l2+ySWdEmXmDYcXKGGjM1TLu1
	6Lm5UdAHk/rr19dTcgjFoWyZRH5Btz0s9vz0EfiFQNUhJZKqlLuobOVeivAxUtEBEb0ughZcKG+
	rczobIFCW/R8lMvccadNrlmMphpwLNTVERwa4pkAgR3thSxPa4dn9BkNYrTdRcSBL5GkxLpx7yC
	shPWY517GuFqGbuC4HUXPpxGEwRjNpdn387+1UTu81hfR31fmJhscr++3Xz9w4lHf20eZV2T0Gi
	J+I552AQmYluGGnR4Yu9yXDA3yeGLXfkV2Utf48vRv0Qg4aY6C2Oi/jiFontAVP3WAD9RO6SspZ
	3wygwVvdR6YvWgIFMRqEruvbU8cccneYC5/HgWc2NcMlXAk8mvddZWB3p
X-Received: by 2002:a05:6402:1ed6:b0:6aa:e3f3:c9df with SMTP id 4fb4d7f45d1cf-6afe29d4fbbmr2351528a12.20.1791309684915;
        Tue, 06 Oct 2026 11:01:24 -0700 (PDT)
X-Received: by 2002:a05:6402:1ed6:b0:6aa:e3f3:c9df with SMTP id 4fb4d7f45d1cf-6afe29d4fbbmr2351504a12.20.1791309684437;
        Tue, 06 Oct 2026 11:01:24 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (188-142-152-55.pool.digikabel.hu. [188.142.152.55])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb01e5942sm5056684a12.9.2026.10.06.11.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 11:01:23 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev
Cc: John Groves <john@groves.net>,
	Amir Goldstein <amir73il@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: [PATCH v3 2/9] dax: use READ_ONCE() in dax_holder()
Date: Tue,  6 Oct 2026 20:01:07 +0200
Message-ID: <20261006180115.1425232-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261006180115.1425232-1-mszeredi@redhat.com>
References: <20261006180115.1425232-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ma-tYfsCBijxRSw1Rk4l1SAY1tzBEu1-rfGliRi4S0A_1791309685
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Make sure that a non-NULL check in callers remains valid even when racing
with fs_put_dax().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 drivers/dax/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 824e1f6df378..0a440f8b42e4 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -677,7 +677,7 @@ EXPORT_SYMBOL_GPL(put_dax);
  */
 void *dax_holder(struct dax_device *dax_dev)
 {
-	return dax_dev->holder_data;
+	return READ_ONCE(dax_dev->holder_data);
 }
 EXPORT_SYMBOL_GPL(dax_holder);
 
-- 
2.54.0

