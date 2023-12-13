Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlmQnaSh"
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E28DB
	for <linux-cxl@vger.kernel.org>; Wed, 13 Dec 2023 03:02:54 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c66988c2eeso4938369a12.1
        for <linux-cxl@vger.kernel.org>; Wed, 13 Dec 2023 03:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702465373; x=1703070173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L5aquColKJXO2+9UcheTx0J5BGDHJZ+Nav/r/8zWhRY=;
        b=NlmQnaShwLdKJAWH7M3X1ZIPCDkl4gxr0fDKtjAON5p8+RuDA5OU+3Fd6Cy4HDkZIb
         BT+Ry0UrRetVi1oYguVITRDwlFDM9LFh57JeUYe12IAFWwW5bhpzW3Gb4pGpV1TA8r3M
         oYB80ccMVKWJqY4d2s+u4YrTyiNXFN6c9nHAwjyC9T1cg7N1Oq3hRxq/7fFfe+YU933f
         2/6ZNgWbzCuVvbNTVPS9lt7J4Jf5uUyn7YOcGeB3mMveAC2cSkbLyjviEbU4MBPY0e1K
         K4EqBfPUamqjZkADtdspjW+eAJZIfcmbyMJh5qHfl1GTSk7lfXEdI7KsgMi1yoUKhoVS
         UvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702465373; x=1703070173;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5aquColKJXO2+9UcheTx0J5BGDHJZ+Nav/r/8zWhRY=;
        b=wnU2lpjKvsHc4e6Pe2asPlLWq9voRibNSVDI0BN3gh+ORk1H1RcTGGjZDEgutIOWDN
         7pusQGzPuLero6T9FqPaVc0GmchgzxVpFt0iJOT27bJCbXHiP5xWIMuOerOui9dmwYQQ
         k238Jndh4JZ+LXHwmUuew5Ic7m32PGMf0ctsYUD37ag7H5Z7aQLleDw8q0JE8RyKYcyG
         FWn1Wd5dt+iyYDnEssQP7ak4uM5vw4MMvUYoe69pDNgPAfvb/WBxbvkUDq7U5QRYIlNN
         elBqPPoMOR6yAou8lF8Ng1ss92M4w/0LDmCzr7qjVtlO7BcNezv1gq1IKV8SPqu1wRdR
         tzxg==
X-Gm-Message-State: AOJu0YyZa/MfbPtD5N2zc8TVF0vjrBwCCMuTGz37qV9dos7RoOESvs+M
	BGf/IlP+p06bVMEU0PEGKOZmq9afKF+xj+8Tee0=
X-Google-Smtp-Source: AGHT+IGGKknETKng3zpDnDYQt6gEosXqy6ucJum0OZ5nVpjnmWF/rSrC1m3EfC2Qq3oyHKBmwKGYdfEDsDc8U8/L8sY=
X-Received: by 2002:a17:90a:c87:b0:28a:d7cd:50e with SMTP id
 v7-20020a17090a0c8700b0028ad7cd050emr1828259pja.36.1702465373502; Wed, 13 Dec
 2023 03:02:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NISHAD TAKSANDE <nishadtaksande@gmail.com>
Date: Wed, 13 Dec 2023 16:32:42 +0530
Message-ID: <CAOzEdP9v7t6aAZ2guJRmT_HnJs5TVJPjPok5enG4sHErLmf=ug@mail.gmail.com>
Subject: RE: Device Detection
To: wj28.lee@samsung.com
Cc: ks0204.kim@samsung.com, linux-cxl@vger.kernel.org, 
	NISHAD TAKSANDE <nishadtaksande@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

Thank you for the advice and sorry for the delayed response.

It is right to deduce that the device is not enumerated from the BIOS
side, (and we are constantly trying to achieve this enumeration)
as we have checked the kernel dmesg and also in the UEFI shell with
'pci' command in our Host machine, we didn't see our vendor id or
device id.

We have also checked the acpi tables list and the following tables rae visible:
APIC  BGRT   dynamic/  FACS  HEST  IVRS  SLIT  SSDT1  SSDT4  WSMT
ASPT  data/BERT  ERST  FIDT  HMAT  MCFG  SPMI  SSDT2  SSDT5
BERT  DSDT   FACP      FPDT  HPET  MSCT  SRAT  SSDT3  SSDT6

So can you tell if we are also supposed to get CEDT (CXL Early
Discovery Table) and CDAT (Coherent Device Attribute Table) get listed
among these?

I have also uploaded the kernel log and other information if it helps,
on the following link: https://pastebin.pl/view/38173eff

We have followed the cxl 1.1/2.0 specification while creating the
bitstream file but seems there is some problem in it.
So we believe that, if we could get some guidance on the design side
from you (for eg. minimum requirements) for creating a stable
bitstream file,
which will have the capability to get the device enumerated and
detected in our host machine, then remaining issues would start
settling.
so please let me know and once again, thank you for taking the time
and probing into this issue.
I await earnestly for your suggestions.

with regards,
Thank you
