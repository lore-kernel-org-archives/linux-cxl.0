Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B6F7D3FB
	for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476917; cv=none; b=B/YgLSHymxD/9v2F7i5Qm7W8ivZaVE1HK0p4drg2/+23i92YAktip7gkhmhab1J5tJwE0jzD8TCpB7poQ/SFlo1TiiOGlVctibAgiEd5/bfQreOVwi0quX67ZMFRDrbIbW6pyth/LNCjGpl/iabxteCwi74KgBVN+jveFhiBUps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476917; c=relaxed/simple;
	bh=pDCMsdBXiYQFL4TzhqZzR01ZDQvJHMuloJouxjDPW00=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=edXF7exNwQcYa0wWdhIb8ESR1FRm0IMChrt0Oj8471tXx3ti91u5yFbaW3cdOn/QVXBQrbLaECRm5l4SJNixtt34WUiXWs3gEH1OWx0CfhU+abN5J+Uk47OpXrG2X2dDuIkKAnrNaXt9ZomulT6VVmCK+cGvZ56Mv0JZKjZL6oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amKXEhTT; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amKXEhTT"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-64361817e78so50547867b3.1
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 01:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719476915; x=1720081715; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pDCMsdBXiYQFL4TzhqZzR01ZDQvJHMuloJouxjDPW00=;
        b=amKXEhTTWAqLbElFuOUOfuXDhBVPgKkav5jI5+5gzxUH9rvCwujZoi8w816KIQdkw3
         f3D8/C3+SeGSrh+5ZmQS+IgqjF6Qz7dZAabJq7sqgpZi78S+6+OHl5SdAZ3l2JNqUQom
         b2OsUxJdQY/V2nxtVrzmH/nnHgzvRnvstAYOUbLVsN+d2UowsE+eR9YYK9TAdjrmTE4k
         UXtCNwZJL58wxDGI8xLxRdy/m1d66ZUiUwpmO4wLDGNIeK6o4I4jb0mPo6OdCPbysSP4
         9/ceDKAuoR7p878HRZmYp8QAm7QbUKhNIgtowdsfq3ondmEQPqpdqKPcEoj3T7VRcWds
         G2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719476915; x=1720081715;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDCMsdBXiYQFL4TzhqZzR01ZDQvJHMuloJouxjDPW00=;
        b=KJnqZNuFCGxdHiJQuW/j5tvdOHVMrgO3rCXyTGhhpO/v853v7p69QvxIu61IP1DeVk
         7gUbExQPkNgVOFcnySCfhdW9YmWx/uQdWq08y/bl8A63zKjrPcb0t2Ja7VrjlJsGjUDi
         u4ihMi8eLwBmTj7dv29DxzT0gvwMYuBnq/WTegSnZt0DQzerLeYRiwdXgOB4PNB8+wEe
         GRth3srl84s4kKzcGzAXf5WadjWzAeOfh7lGGqEmjpofqPcNkNREy0M4bMdtEKsTGEED
         LeBEn8uLjRqCOzuX/drqZ/qDva4XbF6+j3+/y2/tIWHEOOoz3dXTdTKBYPiGdFyl78c1
         oKIg==
X-Gm-Message-State: AOJu0YyQt3R8fAqUSOvK4aKBPr20VC/C4SF40ZeVdowZLZtHBXQVXu6Z
	s+Yaz8paQuU0ZtrcWEPF7JdkrgKOZJvubTHz9sWuVsMAS5MAKNmenyP40IwkqJEv9SF3TXD1Lrd
	99TzhsJ/yoqfOFYxRdQXqbn7WdNC47aVWzuCI7g==
X-Google-Smtp-Source: AGHT+IE9IdEfn/UXBKUeRGCBECOY+KctZHur+IA2YhrhbT/sxGHaxO19QIVtrE0FHoZ8ER3ToDq3I7/WOS4e7i5wV2A=
X-Received: by 2002:a81:8391:0:b0:61d:fcf7:b79a with SMTP id
 00721157ae682-643a9a023a9mr120071167b3.11.1719476914960; Thu, 27 Jun 2024
 01:28:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yee Li <seven.yi.lee@gmail.com>
Date: Thu, 27 Jun 2024 16:28:24 +0800
Message-ID: <CALX8JfQ1F+DJ1woPP=gFvnEyy4qHqGkN+94CKG5ONQy+L3C5_A@mail.gmail.com>
Subject: Is there any plan to support CXL GPF in Linux
To: linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear All,

Based on CXL Memory Device SW Guide and CXL Spec, the OS driver plays
a part in the CXL GPF sequence for persistent memory (like Samsung
CMM-H).

So, is there any plan to support CXL GPF in Linux?

Including init GPF DVSEC, flush data to GPF domain, etc.


Thanks,
Yee
