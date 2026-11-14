Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640252;
	b=D47a3sph4qeenMvmixuwPi9tRZXKAqv0Cpo5n+7oG3tCTROJ9PytOqKQX1vRVWPl1yPa
	 MuZ1M/V4+pcKJHZ2MX/sL7FjAl1cuABJ7Y9WkK3v/w1hMoDsrFpgN3AqjZcGpduxT23c0
	 mCeCJ+rYQ1865V+E+R1+ZgOJAtdGRnKwEB4XIMYpZ+VmWKUnIRY39ujNEtXWeUmLsH6nc
	 Sy8LUth2F4HE+x5SAmQGKKbswtVR0Kzpwbm4gpUC0p69t4iuqqeSQOez1g5cBFmjO3wLD
	 bSncnk1O8+yR7hVN3PdbMIwHzk9fsVivkMxZ0w5AxZHUcEy4fMQEBrN0fj3Q6FhLGuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+HAKXNFyWuVVus4jyGRYSZgEnC6sp/o+JpWnVYJ3k8U=;
	b=a8ypIbMR0kMjzmSzrAd/McrvYKdnB26y6gdmjW0brFoElUriy0aeRXP+xX6xPaBXNKhJ
	 s5Hbt6drj1VEmP7SVC4dmosaAlfoydA7rTx74TH2oj2W4gK6qrFnEdaMbwS0q7VLBXwVk
	 PCDoE36iKy+ctv/mB9I1hDmFlgeHCxdR4FGi+tAtUx+nKdLo3zMGIuefWJoAlIjLRWGHD
	 T7FW8MYeIjoc4NneFBXKljyoHeEgpJFW4bdc2Ze925JxBzbCNCHVaTxA46gzvJPBhu+vF
	 GlcuQbVjfKUne8RLGt392tCSw1Ld+62gcQy0DWaNHevgcEWtqAtpMqeaTVatIVCjm3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Ok0h8iL2;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B369E606CDB2
	for <linux-cxl@vger.kernel.org>; Sat, 14 Nov 2026 07:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B369E606CDB2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Ok0h8iL2
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-55ade1de0b4so27475901cf.3
        for <linux-cxl@vger.kernel.org>; Fri, 13 Nov 2026 23:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640251; x=1795245051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+HAKXNFyWuVVus4jyGRYSZgEnC6sp/o+JpWnVYJ3k8U=;
        b=Ok0h8iL2T10cI+PFEuVIRGMDCQ8NRP8Fvz/7tqv55sIqhrJCRGSWcCpReX+dtqSuP2
         ju0VM52/CASXF7CQSnL43mof+7dO6XSHI47KpeBuNSnTQDrqrEnd3GcKgPAUVOYGauxT
         de4vnDF+SMAr6UXzmWg3c28ZY4rCoWGd8RqnhDnP6NM0npTcE8VtLbuilixq0g2CEYxs
         +svzoJS5VfpJRygWBIcrxBCy0d2NU/KdVMysL9vxlhdsh6BofY6ssX6fsKSm1C5oxNGX
         mwozWZkGrlxN/J/oH5CRgxpsxUUGABpZxa67EC7pTOlS0qAduZMHCi3ioVdjNWNK0FG5
         e9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640251; x=1795245051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+HAKXNFyWuVVus4jyGRYSZgEnC6sp/o+JpWnVYJ3k8U=;
        b=Rx2v3Ll/fjBqmyUR078VnR6mpujar3vem6cv12umo7eeC0Cw17SoTmQz/6jAEb7V+m
         MWvN6AF8Oq+wzf2zxKTdyYMQ2ISVA03Bv4npkdza19nDTk6kZdFQ0E8LgqsHZIDxPicY
         gzSLypd4Qo0EJ70Tc/2IW9quCaLg2jhIAOBW5h/n+1sLWLGk7Z0RGd4eWzP0k2RpbLKx
         WYpyK479KvIc7Ayrt4G5MEXMyWMl4XJgjVRd314hsaZZX8Xjvwq6JpJo/RDM0/QBZJXP
         /3M/rq6RGYZDmCgavqtM/u/mb7bMu1W9Gdk9lhuZKLdpy9HOFEIN2H15c0qU6+45eKtb
         6jeg==
X-Forwarded-Encrypted: i=1; AL+hErF9bU5MRLIDzBslnCi5griNb89FcDMMebEVORNAo5gTOizsMkrBM5+kiXOctGuMfIOOQZgjT7mxHuo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/E2/0lOJp5tuWpXeplqUVee5cNwOZfYzkiF9DE1vZSSaMMldqu
	wVnUM2HYsIcKXmgC+oxWG60AyNWlTfP8IbrAX7Ctc5ZysRobSbhc8fww0B/ICeVBaGo=
X-Gm-Gg: AYBFou0hdLZE2/XZuhHKKYVm+XmSavihrhcOdGAM3cvenLMqfYrw+jzY1oYyN9RMzXX
	5YRHFAr4e3735fuTpoA3XmbMtWPkz+Zv3jNzQK9oD/wFVNnht/T7aI3oYCgx3qjscHma3m+M47D
	BV5udl+Z7XU3ISPHG2mfGmc29A46DhYbK4voZIeBbh7OEcDA5vu8+EP7w4ZqwJY+EfoosLTtPBV
	tOUpBb/ZjbeKSaOYsZVXQJyYWiiOmaq7+RQWN3VZDW5KcOchTCp3w38xK9jdIKCMccnoZfHeZjl
	HWKFKhOGKLMXeNdn6278Pk6MF9l9D3UOXNub86ojva+53u9MgYxIYc1NSfZWIGsgBWjUy8r/UzY
	zRT5vWOoXtyDw5deUtTGONUyHtS1KkfoEigR2e+0A1cU53/o8fH7U/NqcX+6wWSza2YO0En+f7M
	MFjb80MAC5jW74OvWj5xVLI0t9vMWZk57bjNmuyIGovvn2l+NFR3QgoFl3uA6pQk6B6Kd/xeiGd
	KJ9rTNGwoQGkdfrlAModTSFgpgDBBOiSYE8LK3eRv1ZkeKPlNjZ0hp6WqkyJri2LvJg94QMBIo4
	TF/xbbguK0hiXqWGjPMkQh1Knp0jQ4AjIriBGzw+x9Og+uZRogY4r5BUxZBm55A5Kw1cQuwhkEr
	IqJdZfTNeY6/8KA0=
X-Received: by 2002:a05:622a:191b:b0:535:a5fc:3b58 with SMTP id d75a77b69052e-55ac8b9ba4dmr73074831cf.68.1794640250752;
        Fri, 13 Nov 2026 23:10:50 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:50 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	jirislaby@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	pavel@kernel.org,
	lenb@kernel.org,
	hannes@cmpxchg.org,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	sj@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	rientjes@google.com
Subject: [PATCH 22/22] nodemask: remove the now-unused first_memory_node/next_memory_node
Date: Sat, 14 Nov 2026 02:09:59 -0500
Message-ID: <20261114070959.3490008-23-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114070959.3490008-1-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
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

Both helpers hard-code N_MEMORY, which says only that memory exists.

Every caller now names the state it means, leaving no users of either
helper. Remove them so new code has to pick a node state explicitly
rather than silently getting N_MEMORY.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 include/linux/nodemask.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 7ace610bdd654..eea0ff7601303 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -457,15 +457,10 @@ static __always_inline unsigned int next_node_state(int nid, enum node_states st
 }
 
 #define first_online_node	first_node_state(N_ONLINE)
-#define first_memory_node	first_node_state(N_MEMORY)
 static __always_inline unsigned int next_online_node(int nid)
 {
 	return next_node_state(nid, N_ONLINE);
 }
-static __always_inline unsigned int next_memory_node(int nid)
-{
-	return next_node_state(nid, N_MEMORY);
-}
 
 static __always_inline void node_set_online(int nid)
 {
@@ -509,9 +504,7 @@ static __always_inline unsigned int next_node_state(int nid, enum node_states st
 }
 
 #define first_online_node	0
-#define first_memory_node	0
 #define next_online_node(nid)	(MAX_NUMNODES)
-#define next_memory_node(nid)	(MAX_NUMNODES)
 
 #define node_set_online(node)	   node_set_state((node), N_ONLINE)
 #define node_set_offline(node)	   node_clear_state((node), N_ONLINE)
-- 
2.53.1-Meta

