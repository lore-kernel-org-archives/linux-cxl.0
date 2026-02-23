Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A654C3783C5;
	Mon, 23 Feb 2026 21:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883515; cv=none; b=pl7R8iPa0aFSiUa1I1jeJCcKxw+du8Xq4o1ShE9RRNVkDKGa9rf1dgD5J7nKXcPQAhF+41aJkDvGclyg/ntVplhxqbo9t7aczJvDgtbV+6tMqSDxHcWPfZ31lgS9tDZ7LfDMYfiKp9FGDoS046BCCkLP3DnE4i7B94xiEtNTMcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883515; c=relaxed/simple;
	bh=tsu5t58A+hMh/4asnfpFiFvLKn8I7QPQPIJMQz5jv9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVPcQsUKTnzgSo9FXX/dfmc+nX7JGeYdxCKb41UolMtWs9C+ubAzC3E0mTyywsdDGrkWXkRo11fAkB/ySqIUcQSVRlHmO4U3aAsI8XHZTrG/dyKnlLsnQYUR7LuyFXIpCtp3bmXckZ8pXPVZbEnuwXLU2yO3Nm7eivKATy6Gkh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=hN03osf8; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="hN03osf8"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKZLy3NJDzlh1Wj;
	Mon, 23 Feb 2026 21:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1771883511; x=1774475512; bh=Ajgnl
	lR+MAKnHgOp9bP7UiL+cgWY3NepNSM8pwLzBp0=; b=hN03osf84O8qS2LO/wrES
	VjQyx7447Bx6I6QMZc0tRxfxX3fPCwunK/1sY4e2YsJpmvQzskc9SafjBAUJ8zsi
	E7pPYQg8z11cvhOLUqc6OKqRthSetQ+0RDAkMDdy4im+elqOVWCUtG8XolzO6amD
	ysrUCmmQcEgNUMg7yCNCReuqFS7vNeYWw7f7u6OkabMmfua7ApDdAOZTges5/rgn
	fKqvp4SuW6WVLKULtmqjn0lgr1bRgrV/pTYQuWAqz5/zhsJP2L+gFSMSlFvUkCYA
	5604sEojcdlI00YZOa9ZuZrsONAzB9PluMm4L4dReS+783H46ZJkwDdE8m8bZXVn
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SAN_puEll8YD; Mon, 23 Feb 2026 21:51:51 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKZLp26NGzlfl6N;
	Mon, 23 Feb 2026 21:51:46 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: [PATCH 04/62] dax/bus.c: Fix a locking bug
Date: Mon, 23 Feb 2026 13:50:19 -0800
Message-ID: <20260223215118.2154194-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223215118.2154194-1-bvanassche@acm.org>
References: <20260223215118.2154194-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only unlock dax_dev_rwsem if it has been locked. This locking bug was
detected by the Clang thread-safety analyzer.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Fixes: c05ae9d85b47 ("dax/bus.c: replace driver-core lock usage by a loca=
l rwsem")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/dax/bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index c94c09622516..ebd3806c34e5 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1117,11 +1117,10 @@ static ssize_t size_store(struct device *dev, str=
uct device_attribute *attr,
 	}
 	rc =3D down_write_killable(&dax_dev_rwsem);
 	if (rc)
-		goto err_dev;
+		goto err_region;
=20
 	rc =3D dev_dax_resize(dax_region, dev_dax, val);
=20
-err_dev:
 	up_write(&dax_dev_rwsem);
 err_region:
 	up_write(&dax_region_rwsem);
