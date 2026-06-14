Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E094280325
	for <linux-cxl@vger.kernel.org>; Sun, 14 Jun 2026 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781464200; cv=none; b=syRB1jlr3vP3YmmlWzslohO16WQbTXAjQRI5wz3IfYlKvMoz9lmB2ZinVpwcqH2+TkLmH9FmeLDB76NISe7fhYsdblxC8tpYNofLfLqj+yGbSkRsVLy7MXHKn2gI9k4LwVZV9Qqfo/IM27YygzsPvq7BL7gODGIf3WUEH5jptQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781464200; c=relaxed/simple;
	bh=p+F8HqWCxhcjSstlGqvsBzA4ipgh4zYRWeChM7pLpnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=h34UGQrjatLMClu4TPprX3Ceglc8WN8/a16KO80ZbnLzWS0BZTfH6ewRNu0lXJT0cwFMM5MXihUAVxIUTcmWMhqJZs32BIPp94SgOvXePSSHrLtOunYYDZXxLIzksaHQprjWjQJRP3gBBD3sjln+PLIWEq8gmEBBu1w1dOAG2+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZlmPBCTS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlmPBCTS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781464198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OdLmIBYj2TX81sVsFxeL3brQiveCFghfyugzGHZB+Qw=;
	b=ZlmPBCTSZiR+DLM3j68wY0rPNgZwmThmcjmH0QwaC9rUhfdV8jec47bZeqFz3tNjclbqOO
	Od83dT/h1YyB/+glFH55M/q5eVR1VmyYKbX6WFXaAUYI8mCcpscEJrvuLa5Iy1OfAEeeqD
	BGldBdmjjJZqQillnvToIKk/wJ04Z6I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-8kdna4vqPhivit_X7HNFUQ-1; Sun, 14 Jun 2026 15:09:55 -0400
X-MC-Unique: 8kdna4vqPhivit_X7HNFUQ-1
X-Mimecast-MFC-AGG-ID: 8kdna4vqPhivit_X7HNFUQ_1781464194
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a060eb84so19279815e9.0
        for <linux-cxl@vger.kernel.org>; Sun, 14 Jun 2026 12:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781464194; x=1782068994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdLmIBYj2TX81sVsFxeL3brQiveCFghfyugzGHZB+Qw=;
        b=d0UXMZCXEtuoI0Q6uzJqfLPTl/IVzkfI4QFanEvcqFXozhDlXW7pa/NcnhbE6Qsrdx
         QHW9nw21PVypG1aFaT/6U0UPYd27H08HPrp5aYx2ffJJjB61oFTSeRe2CEZk9cYPKMas
         B1e4cyq6TQedKvFQ6E+henJ6+/FL1eg5aH7Y2pATjtuVNMA3ibs6zwskqOvU0D5YAiWz
         aD43FQU24HDU/oxF+oz4Wwxo0MWb2aeQlYEHG3wevttlYoeB8pLGuVJnRl4AvtSb/rgH
         WDuk+V6NhUjIPz9wugAT6/T1zsW/qqD5V2m09HLNhrsugRcDGcTEV9Pp7qI9U0U7Ri7T
         TQTQ==
X-Forwarded-Encrypted: i=1; AFNElJ/vkV3ibmKYCWsn7OgwjaebYAdOOODMVSsfOmY6IE1eQ5nYcN2+mCOOulm6uDbkPyGy7cifUSbqmuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA03wEZK3Djgbpt+5o0cHoDvlPtreHfNwp0Vco03jrAXLf6vDF
	OFkHQmIlLaTQax2wyvT9pER5NvJC/Lrjm98wfbH1hCDfO6bqDnBW1SEj2lOueXD3WrW0pav9F5T
	7qYcVb8F01jLMorx4M7muxMeuUhaIowotb/uDNm2PpEWLq+IRoX/Tc+42MDG59Q==
X-Gm-Gg: Acq92OFOSFOb2fHVpq4MZ+EjpwBxIkUJN8J6cQgskuJkL3lH2+H67bPHtr5Dkl8ib13
	XxzXYeUqwApyFhle9xMtNnbat6NcaU2RKbQGchmDyGdbg8WCFEGtQe+UlemOHnCwX61kNvMyLkp
	sCECzgedd1GUdtvo38hVQ1xxDzb08PhLkGtI5Gcj9U431suSbzih2FpcK8DH2Y6heSgB+2F2fse
	3L6h+sbGWxpe3EQ+blW2eyl4ui6qWztHQZ/gBXvOP+wnlWWf40Dcqrs4BuD9hNvny2lrEXbv9AZ
	tOv1J1BaxnobkB++WoVoKDYUG5d70EhdlbG/VvKjsOenoB5nAFaDXFoZOr+KB2MUyNiKxV61Nxo
	K+hoilxPi1oLSzFokdpInnUypNtTZFlq5YOK9YyfQ0hk=
X-Received: by 2002:a05:600c:5487:b0:490:ea8a:32da with SMTP id 5b1f17b1804b1-490ec509524mr135639895e9.26.1781464194197;
        Sun, 14 Jun 2026 12:09:54 -0700 (PDT)
X-Received: by 2002:a05:600c:5487:b0:490:ea8a:32da with SMTP id 5b1f17b1804b1-490ec509524mr135639665e9.26.1781464193707;
        Sun, 14 Jun 2026 12:09:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0c10sm27660598f8f.21.2026.06.14.12.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 12:09:53 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Shiju Jose <shiju.jose@huawei.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
Subject: [PULL 100/106] hw/cxl: Add fixes in Post Package Repair (PPR)
Message-ID: <37185e2cf15adfb36ddcee20c444ecccbe26be4d.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oJW6PxKY3v3yJcIHMBQ7dj8FumI1P8sAeUB23DE1VKg_1781464194
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Shiju Jose <shiju.jose@huawei.com>

Add following fixes to the commit: hw/cxl: Add support for Maintenance
command and Post Package Repair (PPR).

In cxl_perform_ppr(), remove and free the maintenance entry from QLIST
if match is found and PPR operation is performed.

Fixes: 5e5a86bab830("hw/cxl: Add support for Maintenance command and Post Package Repair (PPR)")
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260306101423.986-3-shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6b16cc206f..20e0b7e476 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2068,6 +2068,8 @@ static void cxl_perform_ppr(CXLType3Dev *ct3d, uint64_t dpa)
                                 CXL_MEMDEV_MAINT_SUBCLASS_CACHELINE_SPARING,
                                 ent, NULL);
             }
+            QLIST_REMOVE(ent, node);
+            g_free(ent);
             break;
         }
     }
-- 
MST

