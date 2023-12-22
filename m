Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92845D50B
	for <linux-cxl@vger.kernel.org>; Fri, 22 Dec 2023 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSW1N1NG"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d9389583edso1516995b3a.0
        for <linux-cxl@vger.kernel.org>; Fri, 22 Dec 2023 01:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703235660; x=1703840460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9yAIpgz2Vh0MKn7myhvNTnAj6CrivJQ1z40FyPTPo4A=;
        b=jSW1N1NGDRfFRtSzeUrFkA0vU8cR7s0wfslKLu9/w998XfWYxFn2qJNdtqkVTyroFy
         3xLCazfgWikxc6Aszp3dVzYit3S/3ShGwmX/JT0P4f/+9yG6UH5S2uQ34tm4AuELDJiq
         QMe0PrAebn+gZFzyWWgl81RbP4083u6cWSGHTNcZE5cx/lWVqG2hcEuSdzgvcIFe6o5D
         n+6TLshIqLcKKNaYYfBgCQbSHPKaDeU4VZ4pP+tTLC2vgePIeaUXyFBjM1Vwf+EqqEY9
         fozwO1YMHcie6BKx0bpWfJI1J+Xakfqx1G1UY38UDT7GBZ3tHchwqUfXZzTooFHi1lqm
         lNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703235660; x=1703840460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9yAIpgz2Vh0MKn7myhvNTnAj6CrivJQ1z40FyPTPo4A=;
        b=fLirm+XNIhK3drHw1grg4dkT5V2L6d/K0kNoEqi4jib90tvwPQMY4ZooG7MP//79Bo
         3bRKi1UCCtNSqHROB9JMqW2tfwlMDNS+uGep75AWwg465GU7Jwn9NAPMYGJSN3FeFadv
         PmeV+EqE/Pj1vdWHt2hKmKxKsbGmy8FdAyH/NukAOUz+vRblqYIXAJAkxT0dmRaWpU0H
         gvkTNiHIzS4duQQk5LAafpLuwbatEK78DSSlqeeRwrQ9+Kvuq6VqLVn5VaIHfCFwQSrF
         4wTfbnvMGAOoHTttfeO1dIyvjsmeTg1Ay2K9Bn8rJuAG0jRc51P1sRJ9bRXIiFdb0jN1
         Q/vQ==
X-Gm-Message-State: AOJu0YzmRA8RjdwH1ex291fGy3Bs9akmbK3E204IedJXCmIo1AbLprs0
	9lnCfdLxbWe84cjtiOdVznriUzadHryQmSCy
X-Google-Smtp-Source: AGHT+IEbr3uxUm+2S8AOgDuc1pktqVBO/7dV02DFJEJgswOajy2l/V1V51Ixzvzyu72zOLD4TQpmHA==
X-Received: by 2002:a05:6a20:8e0c:b0:18d:10d7:3313 with SMTP id y12-20020a056a208e0c00b0018d10d73313mr1286628pzj.20.1703235659632;
        Fri, 22 Dec 2023 01:00:59 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id f23-20020a056a000b1700b006d990040342sm400560pfu.155.2023.12.22.01.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 01:00:58 -0800 (PST)
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Fan Ni <fan.ni@samsung.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] A Followup for "QEMU: CXL mailbox rework and features (Part 1)"
Date: Fri, 22 Dec 2023 18:00:47 +0900
Message-Id: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/qemu-devel/20231127105830.2104954-1-42.hyeyoo@gmail.com

Changes from v1:
    - Added patch 1 that fixes a build failure in Jonathan's tree.
    - Added patch 3, as (partially) suggested by Davidlohr Buseo.
      One difference is that I dropped sanitize_running(), because
      cxl_dev_media_diabled() is enough for checking if the media is
      disabled (which implies sanitation is in progress)
    - Added patch 4 that dicards all event logs during sanitation

    Thanks everyone for giving feedbacks!

This is a fixup for the recent patch series "QEMU: CXL mailbox rework and
features (Part 1)" [1].

I don't mind if patch 1 is squashed into the problematic patch, as the
patch is not mainlined yet. This is based on Jonathan
Cameron's git tree (https://gitlab.com/jic23/qemu/-/tree/cxl-2023-11-02)

Sequence of Patches:

   1. Fix build error when CXL is not enabled, because of mismatching
      definition in cxl_type3_stubs.c
 
   2. Make mdev_reg_read() actually read registers, instead of
      returning a dummy value. This fixes Media Status being incorrectly
      read as "Enabled" while sanitation is in progress.

   3. Introduce cxl_dev_media_disabled() and replace sanitize_running()
      with it. Also add an assert() to check the media is correctly disabled
      during sanitation. (Now enabling when already enabled, or vice versa
      raises an assert failure.)

   4. Drop all event records during sanitation, as per spec.

[1] https://lore.kernel.org/linux-cxl/20231023160806.13206-1-Jonathan.Cameron@huawei.com

Hyeonggon Yoo (4):
  hw/cxl: fix build error in cxl_type3_stubs.c
  hw/cxl/device: read from register values in mdev_reg_read()
  hw/cxl/mbox: replace sanitize_running() with cxl_dev_media_disabled()
  hw/cxl/events: discard all event records during sanitation

 hw/cxl/cxl-device-utils.c   | 17 +++++++++++------
 hw/cxl/cxl-events.c         | 13 +++++++++++++
 hw/cxl/cxl-mailbox-utils.c  |  7 +++++--
 hw/mem/cxl_type3.c          |  4 ++--
 hw/mem/cxl_type3_stubs.c    |  4 ++--
 include/hw/cxl/cxl_device.h | 16 ++++++++++------
 6 files changed, 43 insertions(+), 18 deletions(-)

-- 
2.39.3

