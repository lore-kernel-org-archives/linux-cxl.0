Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610647;
	b=EMZqtKUb8C0KjInvFkOLLzP71iOMo/3qrl7gRkTozoad2ivMylL51jhv4cSSHOTbD6kD
	 MefHkjn97PpHDzjfuqfH5tDjZ5UUXZeYa8SSjv5AJREvav4gmK+Q/+k0435roq+0IFsFl
	 z4ZO5uTZovh4fGOkT2d7F/rTOSGz2wc280r9bykPHoZgriNMMsiTEcvBIVNiW4gBmkjTW
	 Wwo2l9JE9NmJ2zQ3+5TakvFNqK/LWP12uqTmr1SONsZDL7djd8Q+wTBwtq6UKm80/GWsd
	 5hLyZ3YM0GyeDYqTvh+VOrE2uFphVmEICN9OHZDohJblviu4af7QDeUyUtOcJlT8uaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ly8SpXlXBNY7NQGo8GyDm0rJw1CY1nj9SXG0VugS/hk=;
	b=ar4gIHj4kSgpVQ5Y8AY6cd+3rN8x2ZeMWAXLm7AlsUsPEp4K4qL5ukg0gMvIe2kZMOpk
	 sxJISzo2YJ1itDwwrDu3t3hevmPNpty+bqZ15p4d4J5/wowFGNq5+frOnXcuZ406dQuQq
	 l2XlIF/b5k5qRO1mbLl2ls/k+n/UXJ/g4fC91Xac9Wc7XO4QqiM66tdoIqwURtaJw2F9k
	 T6FDPO+d+G8R9WrJt2qLFywepRPSeLK5ZbOXFkKNRd7lx7OQs+9UV86UrBdecBI7Ez3Dy
	 j2HAL3HgkRSqS0KUS3QNiefHn/5xBMh+jbJKiXocXsU5x9EkUj7qoF6N12ic0TjBg7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pLS4vSCn;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927E606A31E
	for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 12:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E927E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pLS4vSCn
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so3296601c88.1
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 04:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795610646; x=1796215446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ly8SpXlXBNY7NQGo8GyDm0rJw1CY1nj9SXG0VugS/hk=;
        b=pLS4vSCnHrqpyIYH+YvggPOnuseo8Oa8k6AyRdzVMvE+Joqj6L8BrzONuidLnP2L2l
         /fKGRT5gTsqbhhD9MqvzIKU2rOGptKJJc9izwXsoMYCmrYaIkN2alIjM2WNgDdItaaqF
         QDXs13Wa6lBpLrxqAs97hzwWATt09QJKaLBUN4sKU/U/GPe6pHcfNvj3xE/C1kyPR9Hb
         Hfm8FPzdfy3QvOqq8Pfn9QG42sIkCrxq1skCUuoLjIz/7aWvsBjuCuuKytV5QGCNOc8t
         /lrm4MGRyO/4WwCmRXfxwAeO8Kpp663NhM+DwIdX2DMA8Hjksis5BRiXFUdD4Mw25B4z
         FMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610646; x=1796215446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ly8SpXlXBNY7NQGo8GyDm0rJw1CY1nj9SXG0VugS/hk=;
        b=sPtNzwKSlOjBrRZECszMaKc8lIXaAK5J3dTSqzrHTDaZIinc+l7iUcLge5/WLVr9Gm
         Z6abhUixthm8v8Q+kjONlJ18C1hIAbR67dUNPmEEKGUh9f590MCJTv9rH6OQaTIL2Jgm
         Qn1JMTV81L1AWwtL5GU67GvqiFiE2LXCqlbIchi3xFqdeS4dO/c5zjCIZZZ28e8pFf4a
         vMCfeAFxkAWOUsv6CPnHMj0i8MqWGW5bAQH4yYKGd3guPODR7vVNZpyumFTjN3Zm6mck
         /RsLOm2kJ+BULpmfN5KD05gozp37JzmajavfiuyRAjWv7p0tyyGtbaH83CoumkoI3+2m
         pVSw==
X-Gm-Message-State: APuU4Z9F4LySPr8oSNOEq83GJGKszFT/HQzo+5mVw0WBmF9pfpd/SYNV
	C+o2AQcr3m8/7xFNC9MKN+DLyR8S/KRGABym3ryGSdOAWXCMPDDlslGZGHDB8eek
X-Gm-Gg: AZFdTZda78a/9TOblSbhWjd5MzMNNvY/uFj+/FIFPEJ6/RmvN2rghxpDeVa0yvxoJ7q
	hyRBmaFu0eI+nV0iBR7NZ0Jm0EXx5IzXz+o0vbpgEDpK83RSjkHxD/KSD2J3ZTTUwKH6gPBEsH6
	HTv+z6iChSJ7wK3sMsjESHWz8H7/bSj499+G0g3CgzRj8SkvJ68dIbvLqQm7MhzPQpSsIGUV6OY
	mUQCwLp4lu+cNBUFvMj+jmMv1QiL9FbgCyXYTsuYSkGKLLBJa1iRFCADxYw/fRjHno8Mfo1ZVd7
	L+MgwivwAp0DtlMakXDc9h2Z+Nb1lTjNQlWnUPyJDIQVD0nAByWeItPierbLEu7nHdthtkaJLYb
	h7YbzsvcZOYZr7wRmYkKv5KWZaVBUkoFd2gJxnOj3bPKvlu6a5T8mxAu29ie5PWnbCG980PXI77
	rr6QPXyV6N5eyyGXYKXt2T+EvY8Al1VaEssw7qE9vbipXoYolQJoFAGX8GBLciz+Iy71bqIPM2v
	DkBWg6iRR7Hzf2GcRDx4MGrN6owbfF3bNWKDnnl4vs4eQBOIQC9V7rvQIzruiPHrk5mOUBkvi65
	aCe+fMCAvNohwj2DZQ/p9KqWWWD8NnxuFwj0lj33WJo=
X-Received: by 2002:a05:693c:41d4:20b0:386:cedf:5e51 with SMTP id 5a478bee46e88-386cedf61efmr2398665eec.26.1795610645949;
        Wed, 25 Nov 2026 04:44:05 -0800 (PST)
Received: from localhost.localdomain ([121.134.184.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm55841836eec.6.2026.11.25.04.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:44:05 -0800 (PST)
From: Unsung Lee <unsung0317@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	John Groves <jgroves@micron.com>
Subject: [RFC PATCH 1/4] cxl/memdev: Poll for completion of Activate FW
Date: Wed, 25 Nov 2026 21:43:55 +0900
Message-Id: <20261125124358.3583223-2-unsung0317@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125124358.3583223-1-unsung0317@gmail.com>
References: <20261125124358.3583223-1-unsung0317@gmail.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_mem_activate_fw() sends Activate FW without poll_interval_ms and
poll_count. If the device answers "background command started", the
mailbox code skips its wait loop and fails at once with -ETIMEDOUT
("timeout waiting for background (0 ms)"), so the firmware upload is
reported as a hardware error while the device may still be activating.

Give the command the same 1 s x 30 budget as Transfer FW.

Signed-off-by: Unsung Lee <unsung0317@gmail.com>
---
 drivers/cxl/core/memdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 787988e929..67f467c267 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -949,10 +949,18 @@ static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
 	if (slot == 0 || slot > mds->fw.num_slots)
 		return -EINVAL;
 
+	/*
+	 * Activate FW may complete as a background operation. Without a
+	 * poll budget the mailbox gives up at once and reports a timeout
+	 * even though the device is still activating. Use the same budget
+	 * as Transfer FW.
+	 */
 	mbox_cmd = (struct cxl_mbox_cmd) {
 		.opcode = CXL_MBOX_OP_ACTIVATE_FW,
 		.size_in = sizeof(activate),
 		.payload_in = &activate,
+		.poll_interval_ms = 1000,
+		.poll_count = 30,
 	};
 
 	/* Only offline activation supported for now */
-- 
2.34.1

