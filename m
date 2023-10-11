Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88AE182CA
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ii0spfQe"
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078FEB0
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 07:57:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32caaa1c493so1699300f8f.3
        for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697036263; x=1697641063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=so+dYAsr98/gsuN5AgiYYXfVPs/tjHMIteq+n2+KmCM=;
        b=Ii0spfQeOiXLB2QxfKBExjnpkyHoD2daU/vvEPio5Xssc3TKhHerUjDvRm7TpKuAv5
         NXVTvxsbPsxH7oTlHCf0y2iMgR19eJ79zpfP5/SoXvWUISskwB9NDruOZAt6vu6YguXi
         lnwnsVlMECdpQsNFwP1Sx5vasU2ArMnhtUDhe3Q5Wgcj8+ZYwl6r13UDOI33+z8o6VT5
         tR2oOC0L0KmPSAXcCIPxXYjqWAkRb37kfvWHJpLZNhfwxej9KkNwKAo0U+06Oe0MiqvD
         VY92QV9ZBIc7CmHU8OUHACdA1zQb9lDkvTzs9J1FKwrzixgv04IMxIdT6MsFhf/cpXHa
         Gdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697036263; x=1697641063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=so+dYAsr98/gsuN5AgiYYXfVPs/tjHMIteq+n2+KmCM=;
        b=KEH283WCcChpACnkupG78CEgEV7ix0k/ZMcuKFdonW7DjXjwaN8dKDyQDq0WtE0JjC
         +mc8VWsEQVY9AbtnezeF5+gcvhpIOJTBPsxyiJIn5BBZ0mZFg1G1dpVGktxlU62ABTJe
         4ikfl1iDSQLaT3qJsdSPkObI2kjKD5GkgFA8NVuPmPFpiuOqX1BSlQLWMo+8Ic5K7kD4
         QaP1z80Yo2XuWU8zMaNOtrZrZx6o+6azIHeVpRccdW7io+xBwo5WUTNVpaAvF8Z3/aYd
         lUrO7aPJtgQuV67ZHJgMoewtSau6LAK1K9Aje/5A6qZZVPerzT2GZtSaHljMyyVL+fO5
         DXMw==
X-Gm-Message-State: AOJu0Yy8IjLKVg5xHm9OZVzGaVp0li3m79YEpkaZV9ItyXmNOgMpBAq7
	EXjMGthogChq0C/+Wp+f6pb2TQ==
X-Google-Smtp-Source: AGHT+IEwLloZhv32O6QD3URxhj91zvGtv5+r8qbP7nycm08mQoWtxI4198w4oUYh/6YZ71iKt7sCIA==
X-Received: by 2002:a5d:5889:0:b0:329:6be4:e199 with SMTP id n9-20020a5d5889000000b003296be4e199mr16823451wrf.13.1697036263380;
        Wed, 11 Oct 2023 07:57:43 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k7-20020adfb347000000b0032d8913f3dasm1489216wrd.97.2023.10.11.07.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:57:43 -0700 (PDT)
Date: Wed, 11 Oct 2023 17:57:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jim Harris <jim.harris@samsung.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] cxl/region: don't try to cleanup after
 cxl_region_setup_targets() fails
Message-ID: <a85253a4-01a2-480f-af18-6a6d4eff96db@kadam.mountain>
References: <169696311899.1171696.7812961484055097837.stgit@bgt-140510-bm03.eng.stellus.in>
 <CGME20231011145132uscas1p13e9fb6dadfa3d5b61fc410449122a013@uscas1p1.samsung.com>
 <169703589120.1202031.14696100866518083806.stgit@bgt-140510-bm03.eng.stellus.in>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169703589120.1202031.14696100866518083806.stgit@bgt-140510-bm03.eng.stellus.in>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Acked-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

