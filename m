Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B4042BE85
	for <linux-cxl@vger.kernel.org>; Thu, 30 Jul 2026 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416369; cv=none; b=EmK+nfZJ+oo2c+ZkJ+alHtH2DRy5zq1pGI2d19Yy800X+oiKDtlREOQTea90cCjHdkjP3m97AmmzjNi6IJUKDOM5Pfjc/nqMxS3FZdaMcvXdw8tp+ziSBT4GOyKXVkAJqzQCAvuLazQkMe4a95+VgQhFki+2ATwogjGtDyYW7rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416369; c=relaxed/simple;
	bh=CC1aI9uWktVgOtbfJgpL/VSvJeVGX2Mx5TzH4LHt3q4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RMuX9EywmV6edjm0mXoAA/Tb2f7HfxkjrI/7/Eo3yAbfu4IGpYvjXTO7U/5PwxAy4r/xDPMdj12TMyYGIgqX84O0TYjvU4kla2XFDXkDyQq8cRZXRFUr2PcZENM8b0iYK4Zh24OOph0D96AtHrNtD6LoWq8XBExdmGysKVsAaJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ikUbjpj5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikUbjpj5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785416365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDS4TkMha0gHH0wVcrCrut/csLSeIVhxyOKouJJJjDU=;
	b=ikUbjpj52lMI1fiUCPKm4x+y23MJTiDoOGhlX1cprAcFkBXds16l8xH6oMdoFmkUuNr9vS
	2b2hxmHinT0oD5b6FuJ0YQCVtB8HIHJVy2RpiHVFUL7ubtjYbd7MpPHSkdbln7hnRTGQU7
	gl91H/JZTsML2boFVKMqkKPjGKceFys=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-4tyhKubONrCWr4rAUTIOHA-1; Thu,
 30 Jul 2026 08:59:22 -0400
X-MC-Unique: 4tyhKubONrCWr4rAUTIOHA-1
X-Mimecast-MFC-AGG-ID: 4tyhKubONrCWr4rAUTIOHA_1785416359
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D31C31800358;
	Thu, 30 Jul 2026 12:59:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D00CD180034E;
	Thu, 30 Jul 2026 12:59:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 74A8021E6920; Thu, 30 Jul 2026 14:59:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Lukas
 Straub <lukasstraub2@web.de>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Zhao Liu <zhao1.liu@intel.com>,  Laurent
 Vivier <laurent@vivier.eu>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Alex
 Williamson
 <alex@shazbot.org>,  zhenwei pi <zhenwei.pi@linux.dev>,  Hanna Reitz
 <hreitz@redhat.com>,  Ani Sinha <anisinha@redhat.com>,
  qemu-block@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,
  linux-cxl@vger.kernel.org,  Jiri Pirko <jiri@resnulli.us>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Fabiano Rosas <farosas@suse.de>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>,  Igor
 Mammedov <imammedo@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
  Gerd Hoffmann <kraxel@redhat.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  linux-edac@vger.kernel.org,  =?utf-8?Q?Marc?=
 =?utf-8?Q?-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>,
  =?utf-8?Q?C=C3=A9dric?=
 Le Goater <clg@redhat.com>,  Jason Wang <jasowangio@gmail.com>,
  qemu-trivial@nongnu.org,  Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 44/44] qapi: convert trivial intro sections for
 block-core.json
In-Reply-To: <87qzkntdpy.fsf@pond.sub.org> (Markus Armbruster's message of
	"Tue, 28 Jul 2026 16:01:45 +0200")
References: <20260723044805.527643-1-jsnow@redhat.com>
	<20260723044805.527643-45-jsnow@redhat.com>
	<87y0f0aikr.fsf@pond.sub.org>
	<CAFn=p-axhB-ezhfD2F8EoFhWT0h92d6oWP6Li1-JdhiXUGbsdA@mail.gmail.com>
	<87qzkntdpy.fsf@pond.sub.org>
Date: Thu, 30 Jul 2026 14:59:12 +0200
Message-ID: <878q6socpr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: rHjsT2D2zCexy73vq2EOY4kjT-ZjH90DEJG7UfFiLLQ_1785416359
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Markus Armbruster <armbru@redhat.com> writes:

> John Snow <jsnow@redhat.com> writes:
>
>> On Fri, Jul 24, 2026 at 4:38=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>
> [...]
>
>>> I believe all the problematic first paragraphs consist of more than one
>>> sentence.  What about splitting "trivial" into "very trivial" (just one
>>> paragraph, no sentence-ending punctuation in the middle) and "hopefully
>>> trivial" (just one paragraph, remainder)?
>>
>> That's tricky to automate, and doing it by hand doesn't sound much fun
>> either... can we just power through one-by-one?
>>
>> Unless you have a script or a trick you believe will help, and then I
>> am happy to oblige.
>
> By hand would clearly be a bad use of your time.
>
> I'll look into automating it.

Lightly tested throwaway script:

#!/usr/bin/env python3

import os
import re
import subprocess
import sys

proc =3D subprocess.Popen(['/usr/bin/git', 'add', '-p'],
                        bufsize=3D1,
                        stdin=3Dsubprocess.PIPE,
                        stdout=3Dsubprocess.PIPE,
                        text=3DTrue)

n =3D 0
while True:
    n +=3D 1
    chunk =3D os.read(proc.stdout.fileno(), 1024*1024).decode('utf-8')
    if not chunk:
        break
    lines =3D chunk.splitlines()
    prompt =3D lines[-1]
    if prompt.find('Stage this hunk') =3D=3D -1:
        print(f"{sys.argv[0]}: no recognizable prompt after chunk #{n}",
              file=3Dsys.stderr)
        break
    #old =3D '\n'.join(filter(lambda l: re.match(r'^[- ]', l), lines))
    #print(old)
    deleted =3D '\n'.join(filter(lambda l: re.match(r'^-#', l), lines))
    if re.search(r'[!.?].*[!.?]', deleted, flags=3Dre.DOTALL):
        proc.stdin.write('n\n')
    else:
        proc.stdin.write('y\n')
    ch =3D os.read(proc.stdout.fileno(), 1).decode('utf-8')

try:
    proc.wait(1)
except:
    print(f"{sys.argv[0]}: git-add appears to hang, sending SIGTERM",
          file=3Dsys.stderr)
    proc.terminate()
proc.wait()

if proc.returncode !=3D 0:
    print(f"{sys.argv[0]}: git-add terminated abnormally (code=3D{proc.retu=
rncode})",
          file=3Dsys.stderr)

