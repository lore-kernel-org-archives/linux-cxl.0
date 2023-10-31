Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BC8365
	for <linux-cxl@vger.kernel.org>; Tue, 31 Oct 2023 00:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Twgu429r"
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29209A6;
	Mon, 30 Oct 2023 17:17:33 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-5afa5dbc378so32361287b3.0;
        Mon, 30 Oct 2023 17:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698711452; x=1699316252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNWxUz2NxLkXz6WG/bZ7peSXHyS5FiPJ8oc8+TIvteE=;
        b=Twgu429rswrnDKBmoRevmM3HiyZt0PiExbpjk4LLMiv68HvjMoJO8kKW5f+AXo79xI
         i6zBNpK1FeNVKxk44pFoYZiO8q+KTp4IUkHmyCzpw9WWB51yJrVqCgUqwg6kqXFRzax9
         vT+Ga6K5lXVJaSCyC/nA6DVC9f6jjtGhvfJ5Am/ZgPZHYhUr7Q/Gta7cgx53K+8U0PMF
         +Ub3NJ9kv06B1EwEMKAHlRWkI0dUiTCuZkRanhuD3s4KuAPNSNtB8AIkcKEryvYJAHjJ
         p6mnN5MyCSFjxRcoIKJOUYsNqyBRg9wOiPrjU/iOMF1AsOUaxAzpRQnJGqAB1ZCCahDw
         //mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698711452; x=1699316252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNWxUz2NxLkXz6WG/bZ7peSXHyS5FiPJ8oc8+TIvteE=;
        b=a5U29xjJGjZB3TWeoAhzD/O9XPTZ+2VLPUdOpMoPWkS/bR8NVjWgFgtzZG+IIIZ0DH
         FfuCcTJ6SAHNX3+xQijlr6bDUKtkFT9w5KZIsyGDpjtaCw65P1F/+4sgIe401mQZkAw8
         SgtlKinu4PZT7gUwG3F2WO5tcVJyuP4iLIBcm1DnV1s6Dx4EExpORztkhr6i4b9KqtY1
         wadbshGp6xVjbSZ35oECwY7k1cPLbT0U1R8m7BWExXzPEEbwygbUUqFDho9ONaZ1iKLL
         M2R0OEt6x87dheLPBbA3Zwn7uN+g0yj0iw4SupgvWso9ZBk2OZeuW27CnYSmtoMRG4bz
         0QJg==
X-Gm-Message-State: AOJu0YxNhbtatdssFbE/37MNXlNcWOqY5na4r2lHEmZaPbx3UTcw1Xns
	MP2NMOxkm4bVQWaptPmyFjZ5Va6AY/8g
X-Google-Smtp-Source: AGHT+IHiq1auQpDzr8PuSc9EuB+mk4N4VYhA8J+nmiUbiZuSKbEEJY8nDcX9smwT7WQo2rzEfbaq4g==
X-Received: by 2002:a0d:e8c9:0:b0:59f:535b:52a7 with SMTP id r192-20020a0de8c9000000b0059f535b52a7mr8943421ywe.48.1698711452166;
        Mon, 30 Oct 2023 17:17:32 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id fc10-20020a05690c314a00b005a7bf9749c8sm113824ywb.4.2023.10.30.17.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 17:17:31 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	linux-mm@kvack.org,
	ying.huang@intel.com,
	akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com,
	weixugc@google.com,
	apopple@nvidia.com,
	hannes@cmpxchg.org,
	tim.c.chen@intel.com,
	dave.hansen@intel.com,
	mhocko@kernel.org,
	shy828301@gmail.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH v3 2/4] node: add accessors to sysfs when nodes are created
Date: Mon, 30 Oct 2023 20:17:19 -0400
Message-Id: <20231031001721.3972-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231031001721.3972-1-gregory.price@memverge.com>
References: <20231031001721.3972-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accessor information is presently only exposed when hmat information
is registered. Add accessor information at node creation to allow
new attributes to be added even in the absense of hmat information.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 drivers/base/node.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 4d588f4658c8..b09c9c8e6830 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -868,7 +868,9 @@ int __register_one_node(int nid)
 {
 	int error;
 	int cpu;
+	int onid;
 	struct node *node;
+	struct node_access_nodes *acc;
 
 	node = kzalloc(sizeof(struct node), GFP_KERNEL);
 	if (!node)
@@ -887,6 +889,20 @@ int __register_one_node(int nid)
 
 	node_init_caches(nid);
 
+	/*
+	 * for each cpu node - add accessor to this node
+	 * if this is a cpu node, add accessor to each other node
+	 */
+	for_each_online_node(onid) {
+		/* During system bringup nodes may not be fully initialized */
+		if (!node_devices[onid])
+			continue;
+		if (node_state(onid, N_CPU))
+			acc = node_init_node_access(node, onid);
+		if (node_state(nid, N_CPU))
+			acc = node_init_node_access(node_devices[onid], nid);
+	}
+
 	return error;
 }
 
-- 
2.39.1

