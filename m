Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC71F92C
	for <Linux-cxl@vger.kernel.org>; Mon, 13 Nov 2023 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=primesoctechnologies.com header.i=@primesoctechnologies.com header.b="HkZHGnOX"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E971D68
	for <Linux-cxl@vger.kernel.org>; Mon, 13 Nov 2023 06:51:11 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50949b7d7ffso6636368e87.0
        for <Linux-cxl@vger.kernel.org>; Mon, 13 Nov 2023 06:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=primesoctechnologies.com; s=google; t=1699887069; x=1700491869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bYHDnd7NE/uMsPi6uKaGM5ZcSqh1+OEfX/OOSBPhO1g=;
        b=HkZHGnOXbu8Gw/309VXFbsDBoj+60F/Q3HLdYUTnxtOYqnWkcPMSen+hCkhJ1JQyRV
         v8LT7gnNjGKu7krnxgyqjXSvOZyk1tqFqwVrzWdlkAtds9VWqwusSCWLkmy3PA9APwnR
         6saiHV0N3EeB/t8gp2IGju1MAb0Y0Js0xCeh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699887069; x=1700491869;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bYHDnd7NE/uMsPi6uKaGM5ZcSqh1+OEfX/OOSBPhO1g=;
        b=FWSx31HAh79K0rDXcjF9TYnKET90n3+hjb07eo1lhT62cIMgmLkX95PNk5UV0mEQsv
         cBBUk1ABUXZ00Jd3d548v2niczXxMoS9DHckrgAbfMAb1STyHVkdol9X7xFjJ9xj6bpB
         2SVO4xYs0T01vPqKE7ffDw8SHK5c0F8Cq7TFN855sD1qQiXs3p5u7WDNE+hgc47a0RHv
         R0OXu884VFXIawAb0FTGCxeMY4Kq/j2TmqbmGKe5dIMnKEO8cpenLzNxKAgtEiJ/88Ca
         8QUGxlm/rgYNnszspIIx5jPvJivFsK3u7lM7OUsfD4xTbjla3sdXr7ROhZv13ZJlhczP
         rkDw==
X-Gm-Message-State: AOJu0YzGFP4foVvtkuVF3eYBrHL5uYrAGQTRkFzb5xk0IM6CVNSND2ql
	NHrzfIa2x6sXGNNE7PXOjQdhqyqLGEvpjnZg2P53ziX7p1Ojxlih9iA=
X-Google-Smtp-Source: AGHT+IGfo0sPMOD2KPxioPljkz33gxHdLCog+bfxq7TojeQbUX1n5Te0RCdg7Lz65WGxO4LDxhRuHfkIgyVdoT+5Dac=
X-Received: by 2002:a19:4357:0:b0:509:4439:9b57 with SMTP id
 m23-20020a194357000000b0050944399b57mr4077256lfj.38.1699887068850; Mon, 13
 Nov 2023 06:51:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jebaselvi J <js@primesoctechnologies.com>
Date: Mon, 13 Nov 2023 20:20:57 +0530
Message-ID: <CAEMU0qr_0o94pOjjDr=xry6yx-j3YxpGm+LymKTSibY8Z+nUVg@mail.gmail.com>
Subject: CXL enumeration
To: Linux-cxl@vger.kernel.org
Cc: k.jayasree@primesoc.com
Content-Type: text/plain; charset="UTF-8"

Hi All,
 We are trying to get our CXL 1.1 device enumerated using CXL1.1
Host(AMD processor).
We could see only CXL  IO  flits related to DL layer like Init FC1,FC2
and update FCs.
DL layer is up in both CXL host and device, after which there is no
Configuration CXL.io packets from CXL host, and our device does not
get listed in lspci.
Pl let us know , if any driver logs could be enabled to check for this case.
Also IO VLSM is only active , and no ALMP packets from CXL host
initiated for CachMem VLSM.
Regards,
J.Jeba
