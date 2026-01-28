Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC31934D4E6
	for <linux-cxl@vger.kernel.org>; Wed, 28 Jan 2026 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594123; cv=pass; b=uOSCCnMFZ6eKlUli26VS6YBQEfduRQ+fsTm0AmfTxbkC6FYfhWj2l4ip/WxfRu5jY+Di33xb7gdf6t4PsHcl0frZHz1qipQdoBKxL+hBptiFISW05imhsmOw4erY3TV8uNU5IRSXvn90jk/zHFYG2pb40249vPvygjD/FgBX5Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594123; c=relaxed/simple;
	bh=F4vWOsOzvxI7fhzkQA2KN6VAyKQg6qiHMb1clN3iLvA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ULWGY8VJpNQONfeygeXCNRyQFfXQ2jveTOEP40OWYt8AIiU6R30o3aC77njkqozlqXJDYgNpnaDvxafc3Ez3cLrFztN30ehSMwyi6f1yGURaIR0pE4WX2VJoYyQlC9E3qcuEu86gVpljlm+H+rKBpVeonUtqQf3vnX1I5ubJOyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eC4orTDE; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC4orTDE"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d1916d1e24so153727a34.3
        for <linux-cxl@vger.kernel.org>; Wed, 28 Jan 2026 01:55:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769594120; cv=none;
        d=google.com; s=arc-20240605;
        b=RRw3FVckT5zbZZ5aTA5sDh8zUP8b14YgTmTiFWlKMrvMHa97hnKTS2pcQWQ+U0hjjN
         /KUpq5oqto/waPiCtyNUxFdEePUNMuGWL2uI0Q3dhAyyEb3raAZfXmaaeUmo0sHH59Cv
         Js1t5YJpiFHZaOtBtM3Q9tKSTg5E+DBzoKl0doAefKKkicV9KqNzzFQovKKdylieOcWI
         +bESdyavFsZXgBeunZGua6WsE72OQd4znoJry5ljaSiyaueQ4gn7hz21Q90lyhKgBWlx
         YHpMljs2tTtSCd87C8FQBlH+2GXB00c3Tb/5I8MDUD5YATz3+gEsg2B8Yg1Jvfp/t1CL
         RqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=tHlShbW9AccGaWMs494pseNiSOAIaa9XbWLCVszqEXg=;
        fh=MKJiawRFqb9fcQbZcwhCyLkblv58xG2HH3p64rfrdUg=;
        b=SRpHyuW+yiUu2QUZoQ0IzaO2v8DWjE7RoiGWT0+4ofZzB9bdgC1e/tkw/l8PQ1BsKD
         hf3EeFdtYo7Mq9hDeo18fPvRwzNjYrQ1XuD6XxzLhz2ZHvFyaBdDwDtTAOT+xHDCHTe+
         AJHRbTVDTpBD9DjQ1DVyORXAmLCDoFV6Cjq1J1CX8Olv8m62taFxxXZicvQXnATYgjEt
         bHvE7EXxio0eRWnu94QhP9Dl3znsxdJq0F+gGDmE7PJYQ6Yhe5BUfKXfE9+ViYISFwxc
         B8L+F9QXLoMsaRG+v1N+63rEjTQA3VWPFsVubpvXu4XRW4u9HEVaf69DmUnakd0QttzZ
         kDxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769594120; x=1770198920; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tHlShbW9AccGaWMs494pseNiSOAIaa9XbWLCVszqEXg=;
        b=eC4orTDEpGiIgFDQlrwh+kDsL1FfhHFDyKnf7ksTZZhcZUvS3mqpQmoo+Su+LBLZr+
         5scH4QedXS/ej8ralGJWb2IA+knsfTYrQhuHCadHK8olREMMi23TCQecWbJ4NDjdp1Vu
         5HOcDRCrMg5vb0M/GfU1xmePbl2AhysHReyTk0O98RPSmVNVgX2FXHmSyuW49AspoqI4
         gEte+hKj1TaidQzKZnw95nE8rwVPWtyNKKN+7UOMoTOF8LWLOjUX9Z2JX3MnFqUGE/36
         wfGOkt6H6WPXPiHGXWWG/AMdxCzbw9mRyNa99N3ptv+aVv0VNMk4HnvMNulfApDrZkti
         PRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769594120; x=1770198920;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHlShbW9AccGaWMs494pseNiSOAIaa9XbWLCVszqEXg=;
        b=sysm+SY+ieM7MQL01mFy3nZElHHwuhOkf0i6bwXhIKDf6HCBuQVHWmo2IE11QdAA1T
         j8lgQGTR1zhGElGSo4CX4ykDbUvoV+KTaGgVm0Gmrq5IyJco2BCLCirf6IPqxS1XIAFt
         K2ibqX0qlcR2szSLt3a9us9C2R1uRgs8JHLhaCX2iznUdipok9dPzPpqTKIo3RzGAZHx
         fuvvY+2kzJhp1la9j8Rg7/IsprYGegpQjbCVEoc5GEs4JQx9tO27hQBvv0w/DeS+WLTN
         UK42ZYlcvlCdMbyKQn5QvHVc5mf+Q80R+RbfY5LDHXM4U83AZNmR6vu4zGIyzHCKs5bu
         U3Lw==
X-Gm-Message-State: AOJu0YxAAsRlsOADV4Zw+H44BsoD5nQ+uTYCVIb4RbmTnf0csMz68Q6Y
	lBsLFQspFRyL+i+QPACvQGKL/51fH2p7fWH2SVU+Zkv8xJJ1n3PijTQZjHzG7DWJWcKdwOEYWoO
	sCc0pbBY8s8ky0fPgruGFgt69aU/4aM/qhavpUwV05A==
X-Gm-Gg: AZuq6aIzhp3fCUC+OA98IZPycI5scwviTwqbWKOeSouUjpuPtdQosF885QyLIuCzDxV
	1mYEAqhVxS5t5mhWEvb5wFYj4o8raJRSUcNHJCGTPdtmhoI9Wq7QyMkmgwkIZjF2FaIbU5m4w+X
	kEmjjikbVXnG7igS8amLDok+rFgRvWdUmxTjrtigtwHDTMfNgo4paQOlRjDesEDJbWYNkKhPt67
	viZuyFRzTDY7W+wj+mLpo35d6Z9ZvU7ujC/jmhkln3lT9uvwj2khZDP4A==
X-Received: by 2002:a05:6830:3142:b0:7cf:db7e:2bf6 with SMTP id
 46e09a7af769-7d185104a5fmr2744185a34.30.1769594120404; Wed, 28 Jan 2026
 01:55:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Learner cxl <learnercxl@gmail.com>
Date: Wed, 28 Jan 2026 15:25:09 +0530
X-Gm-Features: AZwV_Qigpwsguioul4fznzPzXq46zYeMmrh6kuBg_tBbLzkemKPjmPB08rGapmU
Message-ID: <CAFNvhHedX__1LdABSRqLXf4rtUWdoK-difOcr7TCWrAfG9Ssgg@mail.gmail.com>
Subject: ubuntu 24.04 not showing mem0 in "cxl list -M"
To: linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi list,

we are trying to setup CXL.mem in ubuntu 24.04 but  "cxl list -M"
shows error as below.
Can someone suggest what could be wrong here, how we root cause it further ?

root@amdgenoa1:/sys/bus/cxl/devices$ cxl list -M
  Warning: no matching devices found
[]


If we do lspci | grep cxl ---  we can see the memory expander but
   there is no mem0 in /sys/bus/cxl/devices

root@amdgenoa1:/sys/bus/cxl/devices$ ls -l
total 0
lrwxrwxrwx 1 root root 0 Jan 28 06:31 root0 ->
../../../devices/platform/ACPI0017:00/root0
root@amdgenoa1:/sys/bus/cxl/devices$

Is there any upgrade required  BIOS / OS etc. We are using supermicro
server(H13DSH, BIOS version 1.2)

Appreciate your response
Regards
